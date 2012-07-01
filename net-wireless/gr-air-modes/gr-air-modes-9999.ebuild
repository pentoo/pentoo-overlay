# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit versionator python git-2 autotools

DESCRIPTION="This module implements a complete Mode S and ADS-B receiver for Gnuradio"
HOMEPAGE="https://www.cgran.org/wiki/gr-air-modes"

EGIT_REPO_URI="https://github.com/bistromath/gr-air-modes.git"

KEYWORDS="-*"

LICENSE="GPL-3"
SLOT="0"
IUSE="+rtl fgfs uhd"
DEPEND=">=net-wireless/gnuradio-3.6.1
	net-wireless/gr-osmosdr
	fgfs? ( sci-libs/scipy
		games-simulation/flightgear )
	rtl? ( net-wireless/rtl-sdr )
	uhd? ( net-wireless/uhd )"
RDEPEND="${DEPEND}"

pkg_setup() {
        python_set_active_version 2
        python_pkg_setup
}

src_configure() {
        mkdir build
	#cd "${S}"/python
	#python_convert_shebangs 2 *.py
	#cd "${S}"/apps
	#python_convert_shebangs 2 *.py
	cd "${S}"/build
	use amd64 && cmake ../  -DCMAKE_INSTALL_PREFIX=/usr -DLIB_SUFFIX=64
	use x86 && cmake ../  -DCMAKE_INSTALL_PREFIX=/usr
	sed -i "s#SET(CMAKE_INSTALL_PREFIX \"/usr\")#SET(CMAKE_INSTALL_PREFIX \"${ED}/usr\")#" cmake_install.cmake
}

src_compile() {
        cd "${S}"/build
        emake -j1
}

src_install() {
        cd "${S}"/build
        emake install
	use rtl && dobin "${FILESDIR}"/rtl_modes.py
}

src_test() {
        cd "${S}"/host/build
        emake test
}
