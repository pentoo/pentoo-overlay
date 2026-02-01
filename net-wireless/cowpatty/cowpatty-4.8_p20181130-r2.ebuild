# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="WLAN tools for bruteforcing 802.11 WPA/WPA2 keys"
HOMEPAGE="http://www.willhackforsushi.com/?page_id=50"

HASH_COMMIT="0a274975040960d85cd68550facf801fc3a9d7df"
SRC_URI="https://github.com/joswr1ght/cowpatty/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-libs/openssl:=
	net-libs/libpcap"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/incompatible-pointer-types.patch )

src_prepare() {
	sed -i 's|clang|gcc|' Makefile || die
	sed -i "s#-O2#${CFLAGS} ${LDFLAGS}#" Makefile || die
	sed -i 's#-pipe -Wall##' Makefile || die
	default
}

src_install() {
	dobin cowpatty genpmk  || die "dobin failed"
	dodoc AUTHORS CHANGELOG FAQ INSTALL README TODO dict *.dump
}
