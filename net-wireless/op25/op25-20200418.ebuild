# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-single-r1

DESCRIPTION="software-defined analyzer for APCO P25 signals"
HOMEPAGE="http://osmocom.org/projects/op25/wiki"
#inherit git-r3
#EGIT_REPO_URI="https://github.com/balint256/op25.git"
#EGIT_REPO_URI="https://git.osmocom.org/op25"
#EGIT_BRANCH="max"
#EGIT_REPO_URI="https://github.com/boatbod/op25.git"

COMMIT="6f106847d78f8bedca805e39b2704195a03d7f9c"
SRC_URI="https://github.com/boatbod/op25/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}
	>=net-wireless/gnuradio-3.7:=[vocoder]
	sci-libs/itpp
	dev-libs/boost
	dev-util/cppunit
	net-libs/libpcap
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

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
	python_optimize "${ED}/$(python_get_sitedir)"

	#this isn't right, but cmake is broken somehow
	dodir /usr/share/${PN}
	cp -r "${S}/op25/gr-op25_repeater/apps" "${ED}/usr/share/${PN}"
	rm "${ED}/usr/share/${PN}/CMakeLists.txt"
}
