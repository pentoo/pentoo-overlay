# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Wlan2eth is a tool that converts wlan pcap to ethernet-like frames."
HOMEPAGE="http://www.willhackforsushi.com/Offensive.html"
SRC_URI="http://www.willhackforsushi.com/code/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_install () {
	dobin wlan2eth
}
