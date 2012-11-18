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

DEPEND="virtual/opencl"
RDEPEND="${DEPEND}
	dev-libs/openssl
	mpi? ( virtual/mpi )
	dev-util/xxd"

export OPENCL_ROOT="/usr"

src_prepare() {
	sed -i -e \
	"s:DESTINATION lib:DESTINATION $(get_libdir):" \
	src/CMakeLists.txt || die "sed failed"
}

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
		-DARCH=x86_64
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc README.md
}
