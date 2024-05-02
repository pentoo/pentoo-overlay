# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Records calls from a Trunked Radio System (P25 & SmartNet)"
HOMEPAGE="https://github.com/robotastic/trunk-recorder"

if [[ "${PV}" == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/robotastic/trunk-recorder.git"
	EGIT_BRANCH="rc/v5.0"
	inherit git-r3
	RESTRICT="strip"
else
	SRC_URI="https://github.com/robotastic/trunk-recorder/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/libfmt:=
	dev-libs/spdlog:=
	dev-libs/boost:=
	net-misc/curl
	net-wireless/gnuradio:=[uhd]
	net-wireless/gr-osmosdr:=
	net-wireless/uhd:=
	!net-wireless/op25
	sci-libs/volk:=
	"
RDEPEND="${DEPEND}"

#-D_GLIBCXX_ASSERTIONS reveals the issue but the code is broken and this only hides it
#https://github.com/robotastic/trunk-recorder/issues/780
#https://github.com/robotastic/trunk-recorder/issues/783
#https://github.com/robotastic/trunk-recorder/issues/894
#https://github.com/robotastic/trunk-recorder/issues/895
#append-cxxflags -U_GLIBCXX_ASSERTIONS

src_install() {
	cmake_src_install
	# https://github.com/robotastic/trunk-recorder/issues/722
	rm "${ED}/usr/include/${PN}/git.h" || die
	cp git.h "${ED}/usr/include/${PN}/git.h" || die
	cp "${BUILD_DIR}/libgit.so" "${ED}/usr/lib/trunk-recorder/libgit.so" || die
}
