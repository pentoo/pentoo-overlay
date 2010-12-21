# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A tool for creating a graphical representation of your network"
HOMEPAGE="http://myoss.belgoline.com/netmap"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-gfx/graphviz"

src_prepare() {
	sed -i "s|-O|$CXXFLAGS|g" belgolib/Makefile makelist/Makefile netmap/Makefile || die
}

src_install() {
	dobin netmap/netmap || die
	dobin makelist/makelist || die
	dodoc README || die
}
