# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

#the app *might* support python3, feel free to test it
PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 cmake-utils git-r3

DESCRIPTION="This module implements a complete Mode S and ADS-B receiver for Gnuradio"
HOMEPAGE="https://www.cgran.org/wiki/gr-air-modes"

EGIT_REPO_URI="https://github.com/bistromath/gr-air-modes.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="rtl fgfs +gui uhd"
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	net-wireless/gr-osmosdr
	dev-python/pyzmq
	dev-libs/boost:=
	fgfs? ( sci-libs/scipy
		games-simulation/flightgear )
	rtl? ( net-wireless/rtl-sdr )
	uhd? ( >=net-wireless/uhd-3.4.0 )
	gui? ( dev-python/pyqwt )"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install

	python_fix_shebang apps/{modes_gui,modes_rx,uhd_modes.py}
	#FIXME: cmakes overwrites sheband so we overwrite bins manually
	dobin apps/{modes_rx,modes_gui,uhd_modes.py}

	use rtl && newbin "${FILESDIR}"/modes.py rtl_modes.py
	use uhd && newbin "${FILESDIR}"/modes.py uhd_modes.py
}
