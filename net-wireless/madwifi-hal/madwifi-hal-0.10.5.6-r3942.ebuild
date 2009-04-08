# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-ng/madwifi-ng-0.9.4.ebuild,v 1.4 2008/07/21 19:13:53 steev Exp $

inherit linux-mod

MADWIFI_HAL_SNAPSHOT="20090205"
MY_PVR=${PF}-${MADWIFI_HAL_SNAPSHOT}
S="${WORKDIR}"/${MY_PVR}

DESCRIPTION="Next Generation driver for Atheros based IEEE 802.11a/b/g wireless LAN cards"
HOMEPAGE="http://www.madwifi-project.org/"
SRC_URI="http://snapshots.madwifi-project.org/${P}/${MY_PVR}.tar.gz"

LICENSE="atheros-hal
	|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="+injection default"
DEPEND="app-arch/sharutils
	net-wireless/athload"
RDEPEND="!net-wireless/madwifi-old
		net-wireless/wireless-tools
		=net-wireless/madwifi-hal-tools-${PVR}
		net-wireless/athload"

CONFIG_CHECK="CRYPTO WIRELESS_EXT SYSCTL KMOD"
ERROR_CRYPTO="${P} requires Cryptographic API support (CONFIG_CRYPTO)."
ERROR_WIRELESS_EXT="${P} requires CONFIG_WIRELESS_EXT selected by Wireless LAN drivers (non-hamradio) & Wireless Extensions"
ERROR_SYSCTL="${P} requires Sysctl support (CONFIG_SYSCTL)."
ERROR_KMOD="${F} requires CONFIG_KMOD to be set to y or m"
BUILD_TARGETS="all"
MODULESD_ATH_PCI_DOCS="README"

pkg_setup() {
	linux-mod_pkg_setup

	MODULE_NAMES='ath_hal(net:"${S}"/ath_hal)
				wlan(net:"${S}"/net80211)
				wlan_acl(net:"${S}"/net80211)
				wlan_ccmp(net:"${S}"/net80211)
				wlan_tkip(net:"${S}"/net80211)
				wlan_wep(net:"${S}"/net80211)
				wlan_xauth(net:"${S}"/net80211)
				wlan_scan_sta(net:"${S}"/net80211)
				wlan_scan_ap(net:"${S}"/net80211)
				ath_rate_amrr(net:"${S}"/ath_rate/amrr)
				ath_rate_onoe(net:"${S}"/ath_rate/onoe)
				ath_rate_sample(net:"${S}"/ath_rate/sample)
				ath_rate_minstrel(net:"${S}"/ath_rate/minstrel)
				ath_pci(net:"${S}"/ath)'

	BUILD_PARAMS="KERNELPATH=${KV_OUT_DIR}"
}

src_unpack() {
	if linux_chkconfig_builtin ATH5K; then 
		die "Warning: ATH5k was built into the kernel, if you want to use madwifi \
		then you must set ath5k to disabled or module in your kernel config."
	fi

	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-release_header_fix.patch
	if use injection; then epatch "${FILESDIR}/${PN}-injection-r3925.patch"; fi
	for dir in ath ath_hal net80211 ath_rate ath_rate/amrr ath_rate/minstrel ath_rate/onoe ath_rate/sample; do
		convert_to_m "${S}"/${dir}/Makefile
	done
}

src_install() {
	linux-mod_src_install

	dodoc README THANKS
}

pkg_postinst() {
	local moddir="${ROOT}/lib/modules/${KV_FULL}/net/"

	linux-mod_pkg_postinst

	einfo
	einfo "The type of the created interface can be controlled through the 'autocreate'"
	einfo "module parameter."

        if linux_chkconfig_module ATH5K; then
		if use default; then 
			/usr/sbin/athenable madwifi
			ewarn "Madwifi has been set to default, this is a bad idea, I hope you know what you are doing."
			ewarn "If you want to use a card that is already inserted you need to modprobe ath_pci."
		fi
		if use !default; then
			/usr/sbin/athenable ath5k
			ewarn "Ath5k has been set to default, if you know what you are doing and you really do"
			ewarn "not want this then set the default use flag and rebuild this package. It is strongly"
			ewarn "recommended that you keep ath5k as default and use 'athload madwifi' if you need to switch"
			ewarn "If you want to use a card that is already inserted you may need to modprobe ath5k"
			ewarn "You can switch between madwifi and ath5k using athload <driver>"
		fi
	else
		if use default; then
			/usr/sbin/athenable madwifi
			ewarn "Madwifi has been set to default and ath5k isn't installed.  It is recommened to"
			ewarn "use ath5k instead of madwifi, you should enable it as a module in your kernel."
			ewarn "If you enable ath5k as a module you can switch between madwifi and ath5k"
			ewarn "using athload <driver>"
		fi
		if use !default; then
			/usr/sbin/athenable ath5k
			ewarn "Madwifi was not installed as default and you don't have ath5k enabled in the kernel"
			ewarn "as a module.  You need to either enable ath5k in the kernel or rebuild with madwifi"
			ewarn "and the default use flag or no driver will claim atheros a/b/g cards."
			ewarn "If you enable ath5k as a module you can switch between madwifi and ath5k"
			ewarn "using athload <driver>"
		fi
        fi

}

pkg_postrm()
{
	if linux_chkconfig_present ATH5K; then
		if use default; then
			/usr/sbin/athenable ath5k
			ewarn "Default driver has been switched from madwifi to ath5k"
		fi
		if use !default; then
			/usr/sbin/athenable ath5k
			ewarn "Default driver for atheros a/b/g cards is ath5k"
		fi
	else
		ewarn "Ath5k is not enabled in the kernel at all, this means you now have no driver to"
		ewarn "use atheros a/b/g cards. Likely you wish to enable ath5k as a module in the kernel"
	fi
}

