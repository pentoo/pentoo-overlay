# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="An efficient SNMP scanner"
HOMEPAGE="http://labs.portcullis.co.uk/application/onesixtyone/ http://www.phreedom.org/software/onesixtyone/"
SRC_URI="http://labs.portcullis.co.uk/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	# Comment out the unnecessary CC and CFLAGS variables from the Makefile
	sed -i -e "s|CC=gcc||g" -e "s|CFLAGS=-O2 -pipe||g" Makefile || die "sed failed"
}

src_install() {
	dobin onesixtyone
	dodoc ChangeLog INSTALL README
	dodir /usr/share/${PN}/
	insinto /usr/share/${PN}/
	doins dict.txt
}
