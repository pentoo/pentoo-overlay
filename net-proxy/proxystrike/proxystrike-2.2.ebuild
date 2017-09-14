# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils
MY_P="${PN}-v${PV}"
DESCRIPTION="A tool designed to find vulnerabilities while browsing an application"
HOMEPAGE="http://www.edge-security.com/proxystrike.php"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/proxystrike/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
IUSE="qt4"
RDEPEND="qt4? ( dev-python/PyQt4 )
	 dev-python/pyopenssl
	 dev-python/pycurl
	 dev-python/sip"

DEPEND="${RDEPEND}"
SLOT="0"
S="${WORKDIR}/ProxyStrike-${PV}"

src_compile() {
	elog "Nothing to compile"
}

src_install() {
	dodir /usr/lib/${PN}
	cp -R "${S}"/* "${D}"/usr/lib/${PN} || die "Copy files failed"
	dobin "${FILESDIR}/${PN}-cli"
	if use qt4; then dobin "${FILESDIR}/${PN}-gui";	fi
	dodoc README CHANGELOG
}
