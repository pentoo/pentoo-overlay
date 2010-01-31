# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${PN}-v${PV}"
DESCRIPTION="A tool to crack md5 hashes by bruteforce or dictionary attack"
HOMEPAGE="http://www.edge-security.com/edge-soft.php"
SRC_URI="http://www.edge-security.com/soft/${MY_P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/nasm"
RDEPEND=""

S="${WORKDIR}"/"${MY_P}"

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
