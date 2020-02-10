# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit linux-mod linux-info versionator eutils

##Stable

MY_P=${P/_rc/-rc}

MY_PV=v$(get_version_component_range 1-3)
DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
CRAZY_VERSIONING="4-sn"
SRC_URI="http://www.orbit-lab.org/kernel/${PN}-2.6-stable/${MY_PV}/${MY_P}-${CRAZY_VERSIONING}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm"
IUSE="atheros_obey_crda debugfs debug-driver full-debug injection noleds tinyversionoverride"

DEPEND=""
RDEPEND="=sys-kernel/linux-firmware-99999999"

S="${WORKDIR}"/"${MY_P}"-${CRAZY_VERSIONING}
RESTRICT="strip"

CONFIG_CHECK="!DYNAMIC_FTRACE"

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -lt 2 6 27 && die "kernel 2.6.27 or higher is required for compat wireless to be installed"
	kernel_is -gt $(get_version_component_range 1) $(get_version_component_range 2) $(get_version_component_range 3) && die "The version of compat-wireless you are trying to install contains older modules than your kernel. Failing before downgrading your system."
	if kernel_is -eq $(get_version_component_range 1) $(get_version_component_range 2) $(get_version_component_range 3); then
		if use tinyversionoverride; then
			ewarn "You have the tinyversionoverride use flag set which means you know for a fact that your"
			ewarn "kernel is older than the compat-wireless you are installing."
			ewarn "Most likely you have no clue what you are doing and should hit control-C now"
			ewarn "before you downgrade your system. Ten seconds to think about it."
			epause 10
		else
			ewarn "Your kernel version is most likely newer than the compat-wireless release you are"
			ewarn "trying to install. If you are certain that your kernel is older then you can set"
			ewarn "the tinyversionoverride use flag to override this safety check."
			epause 5
			die "Your kernel version is too close to the compat-wireless version to risk installation."
		fi
	fi
	linux_chkconfig_module MAC80211 || die "CONFIG_MAC80211 must be built as a _module_ !"
	linux_chkconfig_module CFG80211 || die "CONFIG_CFG80211 must be built as a _module_ !"
}

src_prepare() {
	#this patch fixes a trivial typo in the config.mk
	epatch "${FILESDIR}"/fix-typos-2.6.36_rc5.patch

	#this patch is needed to forcibly enable new ralink chips because the shipped config.mk doesn't enable them
	epatch "${FILESDIR}"/force-enable-new-ralink-pci-2.6.36-rc5.patch

	#this may or may not HELP the channel -1 issue. this is not a fix
	epatch "${FILESDIR}"/channel-negative-one-maxim.patch

	#add support for ubiquiti toy for Ray
	epatch "${FILESDIR}"/ubnt-wifi-station-ext2.patch

	#this patch ignores the regulatory settings of an atheros card and uses what CRDA thinks is right
	if use atheros_obey_crda; then
		ewarn "You have enabled atheros_obey_crda which doesn't do what you think."
		ewarn "This use flag will cause the eeprom of the card to be ignored and force"
		ewarn "world roaming on the device until crda provides a valid regdomain."
		ewarn "Short version, this is not a way to break the law, this will automatically"
		ewarn "make your card less functional unless you set a proper regdomain with iw/crda."
		ewarn "Pausing for 10 secs..."
		epause 10
		epatch "${FILESDIR}"/ath_ignore_eeprom.patch
	fi

	if use injection; then
		epatch "${FILESDIR}"/4002_mac80211-2.6.29-fix-tx-ctl-no-ack-retry-count.patch
		epatch "${FILESDIR}"/4004_zd1211rw-2.6.28.patch
		epatch "${FILESDIR}"/mac80211.compat08082009.wl_frag+ack_v1.patch
		epatch "${FILESDIR}"/4013-runtime-enable-disable-of-mac80211-packet-injection.patch
#		epatch "${FILESDIR}"/compat-chaos.patch
		epatch "${FILESDIR}"/rtl8187-mac80211-injection-speed-2.6.30-rc3.patch
#		epatch "${FILESDIR}"/super_secret_patch.diff
		epatch "${FILESDIR}"/ipw2200-inject.2.6.36.patch
	fi
	use noleds && epatch "${FILESDIR}"/leds-disable-strict.patch
	use debug-driver && epatch "${FILESDIR}"/driver-debug.patch
	use debugfs && sed -i '/DEBUGFS/s/^# *//' "${S}"/config.mk
	if use full-debug; then
		if use debug-driver ; then
			sed -i '/CONFIG=/s/^# *//' "${S}"/config.mk
		else
			ewarn "Enabling full-debug includes debug-driver."
			sed -i '/DEBUG=/s/^# *//' "${S}"/config.mk
		fi
	fi
}

src_compile() {
	addpredict "${KERNEL_DIR}"
	set_arch_to_kernel
	emake KLIB_BUILD="${DESTDIR}"/lib/modules/"${KV_FULL}"/build || die "emake failed"
}

src_install() {
	for file in $(find -name \*.ko); do
		insinto "/lib/modules/${KV_FULL}/updates/$(dirname ${file})"
		doins "${file}" || die "failed to install module ${file}"
	done
	dosbin scripts/athenable scripts/b43load scripts/iwl-enable \
		scripts/madwifi-unload scripts/athload scripts/iwl-load \
		scripts/b43enable scripts/unload.sh || die "script installation failed"

	dodir /usr/lib/compat-wireless
	exeinto /usr/lib/compat-wireless
	doexe scripts/modlib.sh || die

	dodoc README || die
	dodir /$(get_libdir)/udev/rules.d/
	insinto /$(get_libdir)/udev/rules.d/
	doins udev/50-compat_firmware.rules
	exeinto /$(get_libdir)/udev/
	doexe udev/compat_firmware.sh 
}

pkg_postinst() {
	update_depmod
	update_moduledb
	einfo 'You may have problem if you do not run "depmod -ae" after this installation'
	einfo 'To switch to the new drivers without reboot run unload.sh then load
	your needed driver.'
}

pkg_postrm() {
	remove_moduledb
}
