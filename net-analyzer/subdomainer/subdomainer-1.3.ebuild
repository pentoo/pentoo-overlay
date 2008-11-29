# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="This script will search in Google, Msn.search and Yahoo for subdomains related to the target domain"
HOMEPAGE="http://www.edge-security.com/edge-soft.php"
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
	epatch "${FILESDIR}"/"${PN}"-python_fix.patch
}

src_compile() {
	elog "Nothing to compile"
}

src_install() {
	dobin "${PN}".py
	dodoc README
}
