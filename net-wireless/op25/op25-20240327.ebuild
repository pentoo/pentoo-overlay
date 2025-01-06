# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-single-r1

DESCRIPTION="software-defined analyzer for APCO P25 signals"
HOMEPAGE="http://osmocom.org/projects/op25/wiki"
#inherit git-r3
#EGIT_REPO_URI="https://github.com/balint256/op25.git"
#EGIT_REPO_URI="https://git.osmocom.org/op25"
#EGIT_BRANCH="gr310"
#EGIT_REPO_URI="https://github.com/boatbod/op25.git"

COMMIT="563d5e8431620d75e8592bcbcb93c41ded41679e"
SRC_URI="https://github.com/boatbod/op25/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=net-wireless/gnuradio-3.7:=[vocoder]
	sci-libs/itpp
	dev-libs/libfmt:=
	dev-libs/spdlog:=
	net-libs/libpcap
	sci-libs/volk:="
DEPEND="${RDEPEND}
	dev-util/cppunit
	sci-libs/volk:="

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	#https://github.com/boatbod/op25/issues/48
	sed '/set(CMAKE_CXX_FLAGS/d' -i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-Wno-dev
		#https://github.com/boatbod/op25/issues/47
		-DBUILD_SHARED_LIBS=NO
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	find "${ED}" -name "*.py[co]" -delete || die
	python_optimize

	#this isn't right, but cmake is broken somehow
	dodir /usr/share/${PN}
	cp -r "${S}/op25/gr-op25_repeater/apps" "${ED}/usr/share/${PN}" || die
}
