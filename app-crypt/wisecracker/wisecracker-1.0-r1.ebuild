# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib cmake-utils

DESCRIPTION="An open source framework for tools that can distribute brute force cryptanalysis"
HOMEPAGE="http://selectiveintellect.com/wisecracker.html"
SRC_URI="https://github.com/vikasnkumar/wisecracker/archive/v1.0.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="mpi"

DEPEND="virtual/opencl"
RDEPEND="${DEPEND}
	dev-libs/openssl
	mpi? ( virtual/mpi )
	app-editors/vim"

export OPENCL_ROOT="/usr"

src_prepare() {
	sed -i -e \
	"s:DESTINATION lib:DESTINATION $(get_libdir):" \
	src/CMakeLists.txt || die "sed failed"

	cmake-utils_src_prepare
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
