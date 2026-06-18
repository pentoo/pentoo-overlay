# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SocketCAN userspace utilities and tools"
HOMEPAGE="https://github.com/linux-can/can-utils"
SRC_URI="https://github.com/linux-can/can-utils/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

src_configure() {
	local mycmakeargs=(
	    -DCMAKE_C_FLAGS="${CFLAGS}"
	    -DCMAKE_CXX_FLAGS="${CXXFLAGS}"
	    -DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS}"
	    -DCMAKE_BUILD_TYPE=MinSizeRel
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
