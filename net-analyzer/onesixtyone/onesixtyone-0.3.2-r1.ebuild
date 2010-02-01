# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/

EAPI="2"

DESCRIPTION="An efficient SNMP scanner"
HOMEPAGE="http://www.phreedom.org/solar/onesixtyone/"
SRC_URI="http://www.phreedom.org/solar/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i "s|-o|$CFLAGS -o|g" Makefile || die "sed failed"
}

src_install() {
	dobin onesixtyone
	dodoc ChangeLog INSTALL README
	dodir /usr/share/${PN}/
	insinto /usr/share/${PN}/
	doins dict.txt
}
