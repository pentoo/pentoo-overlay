# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="2"

inherit eutils python distutils subversion

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!<app-crypt/pyrit-0.3-r1
	>=dev-util/nvidia-cuda-sdk-3.0
	x11-drivers/nvidia-drivers"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	cd "${S}/cpyrit_cuda"
	distutils_src_compile
}

src_install() {
	cd "${S}/cpyrit_cuda"
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/cpyrit
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/cpyrit
}
