# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Small 802.11 wireless LAN analyzer"
HOMEPAGE="http://br1.einfach.org/tech/horst/"
SRC_URI="http://br1.einfach.org/horst_dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+pcap"

DEPEND="sys-libs/ncurses
	pcap? ( net-libs/libpcap )"
RDEPEND="${DEPEND}"

src_compile() {
	if use pcap; then
		emake PCAP=1
	else
		emake
	fi
}

src_install() {
	dosbin horst
	dodoc ChangeLog README TODO
}
