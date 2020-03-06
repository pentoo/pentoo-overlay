# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils multilib

HOMEPAGE="https://github.com/szechyjs/mbelib"
DESCRIPTION="P25 Phase 1 and ProVoice vocoder"
LICENSE="BSD"
SLOT=0
IUSE="test"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/szechyjs/mbelib.git"
	KEYWORDS=""
	inherit git-r3
else
	COMMIT="9a04ed5c78176a9965f3d43f7aa1b1f5330e771f"
	SRC_URI="https://github.com/szechyjs/mbelib/archive/9a04ed5c78176a9965f3d43f7aa1b1f5330e771f.tar.gz -> ${P}-r1.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

src_prepare() {
	sed -i -e '/TARGET_LINK_LIBRARIES(mbe-static m)/d' \
		-e '/ADD_LIBRARY(mbe-static STATIC ${SRCS})/d' \
		-e 's#mbe-static ##g' CMakeLists.txt
	cmake-utils_src_prepare
}
src_configure() {
	mycmakeargs=(
		CMAKE_INSTALL_LIBDIR="/usr/$(get_libdir)"
		-DDISABLE_TEST="$(usex test OFF ON)"
	)
	cmake-utils_src_configure
}
