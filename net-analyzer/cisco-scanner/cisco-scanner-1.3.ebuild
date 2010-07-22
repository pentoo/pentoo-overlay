# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="scan a network for cisco routers with default passwords"
HOMEPAGE="http://packetstormsecurity.org/cisco/ciscos.c"
SRC_URI="http://packetstormsecurity.org/cisco/ciscos.c"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	cp "${DISTDIR}"/ciscos.c "${WORKDIR}"/ || die
}

src_compile() {
	$(tc-getCC) $CFLAGS ciscos.c -o ciscos || die
}

src_install() {
	dobin ciscos || die
}
