# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python distutils subversion
DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/@89"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="cuda stream"
SLOT="0"
DEPEND="dev-db/sqlite:3
	dev-lang/python[sqlite]
	stream? ( >=dev-util/ati-stream-sdk-bin-1.4.0_beta
		  >=x11-drivers/ati-drivers-8.573 )
	cuda? ( dev-util/nvidia-cuda-sdk 
		x11-drivers/nvidia-drivers )"
RDEPEND="${DEPEND}"

src_compile() {
	epatch "${FILESDIR}/${P}.patch"
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

