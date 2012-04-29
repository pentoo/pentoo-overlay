# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit linux-info

DESCRIPTION="VoIP Hopper is a tool that rapidly runs a VLAN Hop into the Voice VLAN"
HOMEPAGE="http://voiphopper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

pkg_setup() {
	CONFIG_CHECK="~VLAN_8021Q"
	linux-info_pkg_setup
}

src_install() {
	dobin src/voiphopper
	dodoc README USAGE
}
