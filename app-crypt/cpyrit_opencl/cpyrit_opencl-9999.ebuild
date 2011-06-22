# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils python distutils subversion

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opencl-sdk"
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
	python_mod_optimize cpyrit/cpyrit.py
}

pkg_postrm() {
	python_mod_cleanup cpyrit/cpyrit.py
}
