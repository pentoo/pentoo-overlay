# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="WLAN tools for bruteforcing 802.11 WPA/WPA2 keys"
HOMEPAGE="http://www.willhackforsushi.com/?page_id=50"
SRC_URI="https://github.com/joswr1ght/cowpatty/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/openssl:*
	net-libs/libpcap"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's|clang|gcc|' Makefile || die
	sed -i "s#-O2#${CFLAGS} ${LDFLAGS}#" Makefile || die
	sed -i 's#-pipe -Wall##' Makefile || die
	eapply_user
}

src_compile() {
	#makefile cannot handle higher than -j10
	emake -j1
}

src_install() {
	dobin cowpatty genpmk  || die "dobin failed"
	dodoc AUTHORS CHANGELOG FAQ INSTALL README TODO dict *.dump
}
