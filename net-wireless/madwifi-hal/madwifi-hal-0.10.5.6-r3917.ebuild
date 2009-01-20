# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-ng/madwifi-ng-0.9.4.ebuild,v 1.4 2008/07/21 19:13:53 steev Exp $

inherit linux-mod

MADWIFI_HAL_SNAPSHOT="20090116"
MY_PVR=${PF}-${MADWIFI_HAL_SNAPSHOT}
S="${WORKDIR}"/${MY_PVR}

DESCRIPTION="Next Generation driver for Atheros based IEEE 802.11a/b/g wireless LAN cards"
HOMEPAGE="http://www.madwifi.org/"
SRC_URI="http://snapshots.madwifi.org/${P}/${MY_PVR}.tar.gz"

LICENSE="atheros-hal
	|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="injection"

DEPEND="app-arch/sharutils"
RDEPEND="!net-wireless/madwifi-old
		net-wireless/wireless-tools
		=net-wireless/madwifi-hal-tools-${PVR}"

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
	einfo "Interfaces (athX) are now automatically created upon loading the ath_pci"
	einfo "module."
	einfo
	einfo "The type of the created interface can be controlled through the 'autocreate'"
	einfo "module parameter."
	einfo
	einfo "As of net-wireless/madwifi-ng-0.9.3 rate control module selection is done at"
	einfo "module load time via the 'ratectl' module parameter. USE flags amrr and onoe"
	einfo "no longer serve any purpose."

	elog "Please note: This release is based off of 0.9.3.3 and NOT trunk."
	elog "# No AR5007 support in this release; experimental support is available
	for i386 (32bit) in #1679"
	elog "# No AR5008 support in this release; support is available in trunk "
	elog "No, we will not apply the patch from 1679, if you must, please do so
	in an overlay on your system. That is upstreams ticket 1679, not Gentoo's."
}
