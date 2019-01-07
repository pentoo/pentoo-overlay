# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1 flag-o-matic

DESCRIPTION="software-defined analyzer for APCO P25 signals"
HOMEPAGE="http://osmocom.org/projects/op25/wiki"
inherit git-r3
#EGIT_REPO_URI="https://github.com/balint256/op25.git"
#EGIT_REPO_URI="https://git.osmocom.org/op25"
#EGIT_BRANCH="max"
EGIT_REPO_URI="https://github.com/boatbod/op25.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=net-wireless/gnuradio-3.7:=
	sci-libs/itpp
	dev-libs/boost
	net-libs/libpcap
	${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

src_prepare() {
	#workaround: compile with gcc 6
#	append-cxxflags -Wno-narrowing
	append-flags -funsigned-char

	cmake-utils_src_prepare
}

src_configure() {
	python_export PYTHON_SITEDIR
	local mycmakeargs=(
		-Wno-dev
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DGR_PYTHON_DIR="${PYTHON_SITEDIR}"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	#this isn't right, but cmake is broken somehow
	dodir /usr/share/${PN}
	cp -r "${S}/op25/gr-op25_repeater/apps" "${ED}/usr/share/${PN}"
	rm "${ED}/usr/share/${PN}/CMakeLists.txt"
}
