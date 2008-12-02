# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/edge-soft.php"
SRC_URI="http://www.edge-security.com/soft/${P}.tar"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""
SLOT="0"
S="${WORKDIR}"/"${PN}"

src_unpack() {
	unpack "${A}"
}

src_compile() {
	elog "Nothing to compile"
}

src_install() {
	dobin "${PN}".py
	dodoc README
}
