# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

WANT_AUTOMAKE="1.4"

inherit autotools eutils

DESCRIPTION="Converts a Cisco IP phone conversation into a wav file" 
HOMEPAGE="http://vomit.xtdnet.nl/"
SRC_URI="http://vomit.xtdnet.nl/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="net-libs/libpcap
		dev-libs/libdnet
		dev-libs/libevent"

src_prepare() {
	sed -i "s|-O2 -Wall -g|$CFLAGS|g" Makefile.* || die
	epatch "${FILESDIR}"/${PN}-remove-old-libevent-code.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README || die
}
