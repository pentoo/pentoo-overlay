# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

# USE_EXPAND categories
CPD_USE_EXPAND="wifi ethernet various"
# These are officially supported
CPD_USE_EXPAND_wifi="ath5k ath9k ath9k_ap ath9k_htc ath6kl b43 brcmsmac brcmfmac carl9170 rt2x00 wil6210 wl1251 wl12xx zd1211rw"

# These are officially supported
CPD_USE_EXPAND_ethernet="alx atl1 atl1c atl1e atl2"

# These are officially supported
CPD_USE_EXPAND_various="i915"

inherit linux-mod linux-info versionator eutils compat-drivers-3.8-r1

# upstream versioning, ex.: 3.7-rc1-6
UPSTREAM_PVR="${PV//_/-}" && UPSTREAM_PVR="${UPSTREAM_PVR/-p/-}"
# ex.: 3.7-rc1
UPSTREAM_PV=${UPSTREAM_PVR%-*}

DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://backports.wiki.kernel.org"
SRC_URI="mirror://kernel/linux/kernel/projects/backports/stable/v${UPSTREAM_PVR}/${PN}-${UPSTREAM_PVR}-1-u.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="atheros_obey_crda debugfs debug-driver full-debug injection livecd loadmodules noleds pax_kernel"

DEPEND="!net-wireless/compat-wireless-builder
	!net-wireless/compat-wireless"
RDEPEND="${DEPEND}
	>=sys-kernel/linux-firmware-20110219
	virtual/udev"

S="${WORKDIR}/${PN}-${UPSTREAM_PVR}-1-u"

RESTRICT="strip"

CONFIG_CHECK="!DYNAMIC_FTRACE"

pkg_setup() {
	CONFIG_CHECK="~NET_SCHED"
	CONFIG_CHECK="~IPW2200_PROMISCUOUS"
	linux-mod_pkg_setup
	kernel_is -lt 2 6 27 && die "kernel 2.6.27 or higher is required for compat drivers to be installed"
	kernel_is -gt $(get_version_component_range 1) $(get_version_component_range 2) $(get_version_component_range 3) && die "The version of compat drivers you are trying to install contains older modules than your kernel. Failing before downgrading your system."

	#these things are not optional
	linux_chkconfig_module MAC80211 || die "CONFIG_MAC80211 must be built as a _module_ !"
	linux_chkconfig_module CFG80211 || die "CONFIG_CFG80211 must be built as a _module_ !"
	linux_chkconfig_module LIBIPW || ewarn "CONFIG_LIBIPW really should be set or there will be no WEXT compat"

	if use compat_drivers_wifi_b43; then
		linux_chkconfig_module SSB || die "You need to enable CONFIG_SSB or USE=-b43"
	fi
}

src_prepare() {
	if use pax_kernel; then
		for gpatch in "${FILESDIR}"/3.8-grsec/*; do
			epatch "${gpatch}"
		done
	fi
	# upstream might want to see this
	epatch "${FILESDIR}"/${PN}-3.8-bt_tty.patch
	epatch "${FILESDIR}"/${PN}-3.8-ath6kl.patch

	#mcgrof said prep for inclusion in compat-wireless.git but this causes issues
	#find "${S}" -name Makefile | xargs sed -i -e 's/export CONFIG_/export CONFIG_COMPAT_/' -e 's/COMPAT_COMPAT_/COMPAT_/' -e 's/CONFIG_COMPAT_CHECK/CONFIG_CHECK/'
	#sed -i -e 's/export CONFIG_/export CONFIG_COMPAT_/' -e 's/COMPAT_COMPAT_/COMPAT_/' "${S}"/config.mk

	# CONFIG_CFG80211_REG_DEBUG=y
	sed -i '/CFG80211_REG_DEBUG/s/^# *//' "${S}"/config.mk

	#this patch ignores the regulatory settings of an atheros card and uses what CRDA thinks is right
	if use atheros_obey_crda; then
		ewarn "You have enabled atheros_obey_crda which doesn't do what you think."
		ewarn "This use flag will cause the eeprom of the card to be ignored and force"
		ewarn "world roaming on the device until crda provides a valid regdomain."
		ewarn "Short version, this is not a way to break the law, this will automatically"
		ewarn "make your card less functional unless you set a proper regdomain with iw/crda."
		epatch "${FILESDIR}"/ath_regd_optional.patch
	fi

	if use injection; then
		epatch "${FILESDIR}"/4002_mac80211-2.6.29-fix-tx-ctl-no-ack-retry-count.patch
		epatch "${FILESDIR}"/4004_zd1211rw-2.6.28.patch
	#	epatch "${FILESDIR}"/mac80211.compat08082009.wl_frag+ack_v1.patch
	#	epatch "${FILESDIR}"/4013-runtime-enable-disable-of-mac80211-packet-injection.patch
		epatch "${FILESDIR}"/ipw2200-inject.3.4.6.patch
	fi
	if use noleds; then
		sed -ir 's/^\(export CONFIG_.*_LEDS=\)y$/\1n/' config.mk
		epatch "${FILESDIR}/leds-disable-strict-${PV}.patch"
	fi
	use debug-driver && sed -i '/DEBUG=y/s/^# *//' "${S}"/config.mk
	use debugfs && sed -i '/DEBUGFS/s/^# *//' "${S}"/config.mk
	if use full-debug; then
		if use debug-driver ; then
			sed -i '/CONFIG=/s/^# *//' "${S}"/config.mk
		else
			ewarn "Enabling full-debug includes debug-driver."
			sed -i '/DEBUG=/s/^# *//' "${S}"/config.mk
		fi
	fi

	#avoid annoying ACCESS DENIED sandbox errors
	sed -i "s/\${MAKE} -C \${KLIB_BUILD} kernelversion/echo ${KV_FULL}/g" compat/scripts/gen-compat-config.sh || die "sed failed"
	sed -i "s/shell \$(MAKE) -C \$(KLIB_BUILD) kernelversion/echo ${KV_FULL}/g" config.mk || die "sed failed"
	sed -i "s/make -C \$KLIB_BUILD kernelversion/echo ${KV_FULL}/g" scripts/gen-compat-autoconf.sh || die "sed failed"

	# replace scripts/driver-select
	# TODO: convince upstream to adopt this script
	cp "${FILESDIR}/${PF}-driver-select" scripts/driver-select || \
		die "Replacing driver-select failed"
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

	dodoc README.md
	dodir /$(get_libdir)/udev/rules.d/
	insinto /$(get_libdir)/udev/rules.d/
	doins udev/50-compat_firmware.rules
	exeinto /$(get_libdir)/udev/
	doexe udev/compat_firmware.sh

	exeinto /etc/local.d
	doexe "${FILESDIR}"/00-compat-drivers.start
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
