# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Decoder for the g72x++ codec, commonly used by DECT phones"
HOMEPAGE="http://www.ps-auxw.de"
SRC_URI="http://www.ps-auxw.de/${PN}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/g72x

src_compile() {
	gcc $CFLAGS -o decode-g72x decode.c g*.c bitstream.c
}

src_install() {
	dobin decode-g72x || die "failed to install g72x++"
}
