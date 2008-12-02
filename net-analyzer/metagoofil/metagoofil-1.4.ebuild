# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="Metagoofil is an information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="http://www.edge-security.com/metagoofil.php"
SRC_URI="http://www.edge-security.com/soft/${P}a.tar"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""
SLOT="0"
S="${WORKDIR}"/"${PN}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_compile() {
	elog "Nothing to compile"
}

src_install() {
	dobin "${PN}".py
	dodoc README
}
