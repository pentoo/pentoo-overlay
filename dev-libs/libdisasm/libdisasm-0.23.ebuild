# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib

DESCRIPTION="x86 Disassembler Library"
HOMEPAGE="http://bastard.sourceforge.net/libdisasm.html"
SRC_URI="mirror://sourceforge/bastard/$P.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="strip" # we need debug symbols for the disambler to work

src_configure() {
	if has_multilib_profile
	then
		CFLAGS="$CFLAGS -m32"
		CXXFLAGS="$CFLAGS -m32"
		econf --libdir=/usr/lib32
	else
		econf
	fi
}
src_install() {
	DESTDIR="${D}" emake install
}
