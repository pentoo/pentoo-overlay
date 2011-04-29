# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theHarvester.php"
SRC_URI="http://www.edge-security.com/soft/${P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/"${PN}"

src_compile() {
	elog "Nothing to compile"
}

src_install() {
	dobin "${PN}".py
	dodoc README
}
