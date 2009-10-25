# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python distutils subversion
DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
KEYWORDS="-*"
IUSE="cuda stream"
SLOT="0"
DEPEND="stream? ( >=dev-util/ati-stream-sdk-bin-1.4.0_beta )
	cuda? ( dev-util/nvidia-cuda-sdk )"
RDEPEND="${DEPEND}"

src_compile() {
	epatch "${FILESDIR}/pyrit-9999.patch"
	cd "${S}/pyrit"
	distutils_src_compile
	if use cuda; then
		cd "${S}/cpyrit_cuda"
		distutils_src_compile
	fi
	if use stream; then
		cd "${S}/cpyrit_stream"
		distutils_src_compile
	fi
}

src_install() {
	cd "${S}/pyrit"
	distutils_src_install
	if use cuda; then
		cd "${S}/cpyrit_cuda"
		distutils_src_install
	fi
	if use stream; then
		cd "${S}/cpyrit_stream"
		distutils_src_install
	fi
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}

