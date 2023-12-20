# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Digital Speech Decoder"
HOMEPAGE="https://github.com/lwvmobile/dsd-fme"
LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/lwvmobile/dsd-fme.git"
	EGIT_BRANCH="audio_work"
	inherit git-r3

else
	SRC_URI="https://github.com/lwvmobile/dsd-fme/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="
	media-libs/codec2:=
	>=media-libs/mbelib-1.3.0-r1
	media-libs/portaudio
	>=sci-libs/itpp-4.3.1
	media-libs/libsndfile
	sci-libs/fftw:3.0
	media-libs/libpulse
	sys-libs/ncurses:=
	net-wireless/rtl-sdr
"
RDEPEND="${DEPEND}"

src_prepare() {
	#sed '/find_program(HELP2MAN_FOUND/d' -i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DDISABLE_TEST="$(usex test OFF ON)"
	)
	filter-lto
	append-cflags -Wno-error=stringop-overread
	cmake_src_configure
	# the cmake looks right to me, I have no idea why this is needed
	sed -i 's/-lncursesw/-lncursesw -ltinfow/' "${BUILD_DIR}/build.ninja" || die
}
