# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs git-2

DESCRIPTION="SSLScan determines what ciphers are supported on SSL-based services."
HOMEPAGE="https://github.com/ioerror/sslscan"
EGIT_REPO_URI="git://github.com/ioerror/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i /'CFLAGS='/d Makefile || die "sed Makefile"
	sed -i s/'gcc'/'$(CC)'/ Makefile || die "sed Makefile"
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dobin sslscan
	doman sslscan.1
}
