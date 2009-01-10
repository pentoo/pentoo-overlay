# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt61/rt61-1.1.0_beta2.ebuild,v 1.2 2007/08/29 18:56:55 genstef Exp $

inherit linux-mod

DESCRIPTION="Driver for the RaLink RT61 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com/wiki/index.php/Main_Page"
LICENSE="GPL-2"

MY_P=${P/_beta/-b}

SRC_URI="http://rt2x00.serialmonkey.com/${PN}-cvs-daily.tar.gz"

KEYWORDS="-* ~amd64 ~x86"
IUSE="debug"
DEPEND=""
RDEPEND="net-wireless/wireless-tools
	!net-wireless/ralink-rt61"
S="${WORKDIR}/${MY_P}"
MODULE_NAMES="rt61(net:${S}/Module)"

CONFIG_CHECK="WIRELESS_EXT"
ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_WIRELESS_EXT)."

MODULESD_RT61_ALIASES=('ra? rt61')

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNDIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
}

src_compile() {
	use debug && BUILD_TARGETS="clean debug"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc CHANGELOG FAQ TESTING THANKS
	dodoc Module/README Module/STA_iwpriv_ATE_usage.txt
	insinto /etc/Wireless/RT61STA
	doins Module/rt{2{561{,s},661}.bin,61sta.dat}
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo
	einfo "Thanks to RaLink for releasing open drivers!"
	einfo
}
