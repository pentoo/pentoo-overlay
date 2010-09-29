# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python distutils subversion flag-o-matic

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="cuda opencl"

DEPEND="dev-db/sqlite:3
	dev-lang/python[sqlite]
	net-analyzer/scapy
	opencl? ( =app-crypt/cpyrit_opencl-9999 )
	cuda? ( =app-crypt/cpyrit_cuda-9999 )"

RDEPEND="${DEPEND}"

src_compile() {
	# pyrit fails with --as-needed will investigate properly later
	filter-ldflags -Wl,--as-needed
	cd "${S}/pyrit"
	distutils_src_compile
}

src_install() {
	cd "${S}/pyrit"
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
