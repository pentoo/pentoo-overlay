# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Cisco LEAP and Generic MS-CHAPv2 Dictionary Attack"
HOMEPAGE="https://github.com/joswr1ght/asleap"

HASH_COMMIT="254acabba34cb44608c9d2dcf7a147553d3d5ba3"
SRC_URI="https://github.com/joswr1ght/asleap/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="net-libs/libpcap"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {

	eapply "${FILESDIR}/7.patch"

	sed -e "s/-pipe//;s/-Wall//;s/-g3 -Og/${CFLAGS} ${LDFLAGS}/" \
		-i Makefile || die

	sed -e "s/#define VER \"\(.*\)\"/#define VER \"${PV}\"/" \
		-i version.h || die

	default
}

src_compile() {
	CFLAGS="${CFLAGS}" emake CC=$(tc-getCC)
}

src_install() {
	dosbin asleap
	newbin genkeys asleap-genkeys
	dodoc THANKS.md README.md
}
