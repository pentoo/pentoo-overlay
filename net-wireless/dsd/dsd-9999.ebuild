# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

DESCRIPTION="Digital Speech Decoder"
HOMEPAGE="https://github.com/szechyjs/dsd"
LICENSE="BSD"
SLOT="0"
IUSE="test"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/szechyjs/dsd.git"
	KEYWORDS=""
	inherit git-r3

else
	HASH_COMMIT="5077daf644a80c17c39a70f0534532a5375684d9"
	SRC_URI="https://github.com/szechyjs/dsd/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="
	>=media-libs/mbelib-1.3.0-r1
	media-libs/portaudio
	>=sci-libs/itpp-4.3.1
	media-libs/libsndfile
	sci-libs/fftw:3.0
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed '/find_program(HELP2MAN_FOUND/d' -i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DDISABLE_TEST="$(usex test OFF ON)"
	)
	cmake_src_configure
}
