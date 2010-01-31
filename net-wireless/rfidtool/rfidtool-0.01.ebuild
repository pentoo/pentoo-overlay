# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="command line rfid interface"
HOMEPAGE="http://www.bindshell.net/tools/rfidtool"
SRC_URI="http://www.bindshell.net/tools/rfidtool/$PN-v$PV.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/$PN-v$PV

src_compile() {
	gcc $CFLAGS main.c rfid.c -o rfidtool || die "compile failed"
}

src_install() {
	dobin rfidtool || die "install failed"
	dodoc README || die "doc install failed"
}
