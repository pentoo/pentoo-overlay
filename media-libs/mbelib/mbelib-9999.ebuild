# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="P25 Phase 1 and ProVoice vocoder"
HOMEPAGE="https://github.com/szechyjs/mbelib"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/szechyjs/mbelib.git"
else
	COMMIT="9a04ed5c78176a9965f3d43f7aa1b1f5330e771f"
	SRC_URI="https://github.com/szechyjs/mbelib/archive/9a04ed5c78176a9965f3d43f7aa1b1f5330e771f.tar.gz -> ${P}-r1.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT=0
IUSE="test"
RESTRICT="!test? ( test )"

src_prepare() {
	sed -i -e '/TARGET_LINK_LIBRARIES(mbe-static m)/d' \
		-e '/ADD_LIBRARY(mbe-static STATIC ${SRCS})/d' \
		-e 's#mbe-static ##g' CMakeLists.txt || die

	cmake_src_prepare
}
src_configure() {
	mycmakeargs=(
		CMAKE_INSTALL_LIBDIR="/usr/$(get_libdir)"
		-DDISABLE_TEST="$(usex test OFF ON)"
	)
	cmake_src_configure
}
