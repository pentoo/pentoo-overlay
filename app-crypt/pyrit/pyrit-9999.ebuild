# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

inherit eutils python distutils
# flag-o-matic

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"

LICENSE="GPL-3"
SLOT="0"

IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"

IUSE="${IUSE_VIDEO_CARDS} calpp"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
	ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"
	KEYWORDS="~arm ~amd64 ~x86"

	DEPEND="video_cards_nvidia? ( ~app-crypt/cpyrit_cuda-9999 )
		video_cards_fglrx? ( ~app-crypt/cpyrit_opencl-9999 )
		calpp? ( =app-crypt/cpyrit_calpp-9999 )"
else
	SRC_URI="http://pyrit.googlecode.com/files/${P}.tar.gz"
	KEYWORDS="amd64 arm ppc x86"

	DEPEND="video_cards_nvidia? ( ~app-crypt/cpyrit_cuda-${PV} )
		video_cards_fglrx?  ( ~app-crypt/cpyrit_opencl-${PV} )
		calpp? ( ~app-crypt/cpyrit_calpp-${PV} )"
fi

RDEPEND="net-analyzer/scapy
	dev-db/sqlite:3
	video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-275.43 )
	video_cards_fglrx?  ( >=x11-drivers/ati-drivers-12.2 )
	${DEPEND}"

pkg_setup() {
#	append-ldflags $(no-as-needed)
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	# pyrit fails with --as-needed will investigate properly later
#	filter-ldflags -Wl,--as-needed
	cd "${S}/pyrit"
	distutils_src_compile
}

src_install() {
	cd "${S}/pyrit"
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize {pyrit_cli.py,cpyrit}
}

pkg_postrm() {
	python_mod_cleanup {pyrit_cli.py,cpyrit}
}
