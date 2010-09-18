# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="This script will search in Google, Msn.search and Yahoo for subdomains related to the target domain"
HOMEPAGE="http://www.edge-security.com/subdomainer.php"
SRC_URI="http://www.edge-security.com/soft/${P}b.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/python"
S="${WORKDIR}"/"${PN}"

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-python_fix.patch
}

src_compile() {
	elog "Nothing to compile"
}

src_install() {
	dobin "${PN}".py || die
	dodoc README || die
}
