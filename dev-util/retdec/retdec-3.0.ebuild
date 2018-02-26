# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="RetDec is a retargetable machine-code decompiler based on LLVM."
HOMEPAGE="https://github.com/avast-tl/retdec"
SRC_URI="https://github.com/avast-tl/retdec/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#https://github.com/pentoo/pentoo-overlay/issues/258
#KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="app-arch/upx-bin
	sys-devel/bc
	"
#	media-gfx/graphviz

DEPEND="${RDEPEND}
	dev-util/cmake
"

src_configure() {

#		-Dbtrfs-snapshot=$(usex btrfs)
#-DRETDEC_DOC=ON
#-DRETDEC_TESTS=ON
#-DCMAKE_BUILD_TYPE=Debug

	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/opt"
	)

	cmake-utils_src_configure
#mkdir build && cd build
#cmake .. -DCMAKE_INSTALL_PREFIX=<path>
#make && make install
}

src_compile() {
	cmake .. -DCMAKE_INSTALL_PREFIX="${EPREFIX}/opt"
}
