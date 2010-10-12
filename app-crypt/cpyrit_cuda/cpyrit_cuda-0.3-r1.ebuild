# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python distutils subversion flag-o-matic

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/@242"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="!<app-crypt/pyrit-0.3-r1
	>=dev-util/nvidia-cuda-sdk-2.2[pentoo]
	x11-drivers/nvidia-drivers"
RDEPEND="${DEPEND}"

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_compile() {
	cd "${S}/cpyrit_cuda"
	distutils_src_compile
}

src_install() {
	cd "${S}/cpyrit_cuda"
	distutils_src_install
}
