# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/

DESCRIPTION="An efficient SNMP scanner"
HOMEPAGE="http://www.phreedom.org/solar/onesixtyone/"
SRC_URI="http://www.phreedom.org/solar/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
DEPEND=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""
RESTRICT="nomirror"


src_install() {
	dobin onesixtyone
	dodoc ChangeLog INSTALL README
	dodir /usr/share/${PN}/
	insinto /usr/share/${PN}/
	doins dict.txt
}
