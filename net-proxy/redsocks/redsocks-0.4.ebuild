# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Transparent redirector of any TCP connection to proxy"
HOMEPAGE="http://darkk.net.ru/redsocks/"
SRC_URI="https://github.com/darkk/redsocks/tarball/release-${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/libevent"

S=${WORKDIR}/"darkk-${PN}-e0b284d"

src_compile() {
	emake
}

src_install() {
	dobin redsocks
	dodoc README
}
