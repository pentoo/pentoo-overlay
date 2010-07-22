# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="cisco internal bruteforcer"
HOMEPAGE="http://packetstormsecurity.org/cisco/enabler.c"
SRC_URI="http://packetstormsecurity.org/cisco/enabler.c"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	cp "${DISTDIR}"/enabler.c "${WORKDIR}"/ || die
}

src_compile() {
	$(tc-getCC) $CFLAGS enabler.c -o enabler || die
}

src_install() {
	dobin enabler || die
}
