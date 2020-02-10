# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit linux-mod linux-info versionator eutils

##Stable

MY_P=${P/_rc/-rc}

MY_PV=v$(get_version_component_range 1-2)
DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
CRAZY_VERSIONING="2-snpc"
SRC_URI="http://www.orbit-lab.org/kernel/${PN}-3.0-stable/${MY_PV}/${MY_P}-${CRAZY_VERSIONING}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="atheros_obey_crda bluetooth b43 b44 debugfs debug-driver full-debug injection livecd loadmodules noleds"

DEPEND="!net-wireless/compat-wireless-builder"
RDEPEND="${DEPEND}
	>=sys-kernel/linux-firmware-20110219
	virtual/udev"

S="${WORKDIR}"/"${MY_P}"-${CRAZY_VERSIONING}
RESTRICT="strip"

CONFIG_CHECK="!DYNAMIC_FTRACE"

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -lt 2 6 27 && die "kernel 2.6.27 or higher is required for compat wireless to be installed"
	kernel_is -gt $(get_version_component_range 1) $(get_version_component_range 2) $(get_version_component_range 3) && die "The version of compat-wireless you are trying to install contains older modules than your kernel. Failing before downgrading your system."

	#these things are not optional
	linux_chkconfig_module MAC80211 || die "CONFIG_MAC80211 must be built as a _module_ !"
	linux_chkconfig_module CFG80211 || die "CONFIG_CFG80211 must be built as a _module_ !"
	linux_chkconfig_module LIBIPW || ewarn "CONFIG_LIBIPW really should be set or there will be no WEXT compat"

	if use b43; then
		linux_chkconfig_module SSB || die "You need to enable CONFIG_SSB or USE=-b43"
	fi
	if use b44; then
		linux_chkconfig_module SSB || die "You need to enable CONFIG_SSB or USE=-b44"
	fi
}

src_prepare() {
	# CONFIG_CFG80211_REG_DEBUG=y
	sed -i '/CFG80211_REG_DEBUG/s/^# *//' "${S}"/config.mk

	#this patch ignores the regulatory settings of an atheros card and uses what CRDA thinks is right
	if use atheros_obey_crda; then
		ewarn "You have enabled atheros_obey_crda which doesn't do what you think."
		ewarn "This use flag will cause the eeprom of the card to be ignored and force"
		ewarn "world roaming on the device until crda provides a valid regdomain."
		ewarn "Short version, this is not a way to break the law, this will automatically"
		ewarn "make your card less functional unless you set a proper regdomain with iw/crda."
		ewarn "Pausing for 10 secs..."
		epatch "${FILESDIR}"/ath_regd_optional.patch
	fi

	if use injection; then
		epatch "${FILESDIR}"/4002_mac80211-2.6.29-fix-tx-ctl-no-ack-retry-count.patch
		epatch "${FILESDIR}"/4004_zd1211rw-2.6.28.patch
	#	epatch "${FILESDIR}"/mac80211.compat08082009.wl_frag+ack_v1.patch
	#	epatch "${FILESDIR}"/4013-runtime-enable-disable-of-mac80211-packet-injection.patch
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
#	Disable B44 ethernet driver
	if ! use b44; then
		sed -i '/CONFIG_B44=/s/ */#/' "${S}"/config.mk || die "unable to disable B44 driver"
		sed -i '/CONFIG_B44_PCI=/s/ */#/' "${S}"/config.mk || die "unable to disable B44 driver"
	fi

#	Disable B43 driver
	if ! use b43; then
		sed -i '/CONFIG_B43=/s/ */#/' "${S}"/config.mk || die "unable to disable B43 driver"
		sed -i '/CONFIG_B43_PCI_AUTOSELECT=/s/ */#/' "${S}"/config.mk || die "unable to disable B43 driver"
	#CONFIG_B43LEGACY=
	fi

#	fixme: there are more bluethooth settings in the config.mk
	if ! use bluetooth; then
		sed -i '/CONFIG_COMPAT_BLUETOOTH=/s/ */#/' "${S}"/config.mk || die "unable to disable bluetooth driver"
		sed -i '/CONFIG_COMPAT_BLUETOOTH_MODULES=/s/ */#/' "${S}"/config.mk || die "unable to bluetooth B44 driver"
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
		doins "${file}"
	done
	dosbin scripts/athenable scripts/b43load scripts/iwl-enable \
		scripts/madwifi-unload scripts/athload scripts/iwl-load \
		scripts/b43enable scripts/unload.sh

	dodir /usr/lib/compat-wireless
	exeinto /usr/lib/compat-wireless
	doexe scripts/modlib.sh

	dodoc README
	dodir /$(get_libdir)/udev/rules.d/
	insinto /$(get_libdir)/udev/rules.d/
	doins udev/50-compat_firmware.rules
	exeinto /$(get_libdir)/udev/
	doexe udev/compat_firmware.sh
}

pkg_postinst() {
	update_depmod
	update_moduledb

	if use !livecd; then
		if use loadmodules; then
			einfo "Attempting to unload modules..."
			/usr/sbin/unload.sh 2>&1 | grep -E FATAL && ewarn "Unable to remove running modules, system may be unhappy, reboot HIGHLY recommended!"
			einfo "Triggering automatic reload of needed modules..."
			/sbin/udevadm trigger
			einfo "We have attempted to load your new modules for you, this may fail horribly, or may just cause a network hiccup."
			einfo "If you experience any issues reboot is the simplest course of action."
		fi
	fi
	if use !loadmodules; then
		einfo "You didn't USE=loadmodules but you can still attempt to switch to the new drivers without reboot."
		einfo "Run 'unload.sh' then 'udevadm trigger' to cause udev to load the	needed drivers."
		einfo "If unload.sh fails for some reason you should be able to simply reboot to fix everything and load the new modules."
	fi
}

pkg_postrm() {
	remove_moduledb
}
