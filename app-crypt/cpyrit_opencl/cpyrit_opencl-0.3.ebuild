# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python distutils subversion

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/@242"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="!<app-crypt/pyrit-0.3-r1
	dev-db/sqlite:3
	dev-lang/python[sqlite]
	>=dev-util/ati-stream-sdk-bin-2.0
	>=x11-drivers/ati-drivers-10.0"
RDEPEND="${DEPEND}"

src_compile() {
	epatch "${FILESDIR}/${P}.patch"
	cd "${S}/cpyrit_opencl"
	distutils_src_compile
}

src_install() {
	cd "${S}/cpyrit_opencl"
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
