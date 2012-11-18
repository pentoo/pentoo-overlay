# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib cmake-utils

DESCRIPTION="An open source framework for tools that can distribute brute force cryptanalysis"
HOMEPAGE="http://selectiveintellect.com/wisecracker.html"
KEYWORDS="~amd64"
SRC_URI="https://github.com/vikasnkumar/wisecracker/archive/v1.0.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="mpi"

DEPEND="virtual/opencl
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}
	dev-libs/openssl
	dev-util/xxd"

export OPENCL_ROOT="/usr"
CMAKE_IN_SOURCE_BUILD=1

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DARCH=x86_64
	)
	cmake-utils_src_configure
}

src_install() {
#	cmake-utils_src_install
	cd "${S}"/apps
	dobin wisetestmd5
	dobin wisecrackmd5
	cd "${S}"/src
	dolib.so libwisecracker.so
	dolib.a libwisecracker_s.a
	cd "${S}"
	dodoc README.md
}
