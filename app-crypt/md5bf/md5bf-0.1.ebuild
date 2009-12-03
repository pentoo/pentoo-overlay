# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${PN}-v${PV}"
S="${WORKDIR}"/"${MY_P}"
DESCRIPTION="A tool to crack md5 hashes by bruteforce or dictionary attack"
HOMEPAGE="http://www.edge-security.com/edge-soft.php"
SRC_URI="http://www.edge-security.com/soft/${MY_P}.tar"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="dev-lang/nasm"
RDEPEND=""
SLOT="0"

src_compile() {
	sed -i -e "s:gcc:gcc ${CFLAGS}:" Makefile
	emake -j1 || die "emake failed"
}

src_install() {
	dobin md5bf
}

pkg_postinst() {
	elog "Testing binary"
	md5bf -m 5e93de3efa544e85dcd6311732d28f95 -b [97-120] -w [2-6]
}
