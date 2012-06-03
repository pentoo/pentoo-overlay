# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"
inherit versionator python git-2 autotools

DESCRIPTION="This module implements a complete  Mode S and  ADS-B receiver for Gnuradio"
HOMEPAGE="https://www.cgran.org/wiki/gr-air-modes"

EGIT_REPO_URI="https://github.com/steve-m/gr-air-modes"
KEYWORDS="-*"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND="net-wireless/gnuradio
	net-wireless/gr-osmosdr
	net-wireless/rtl-sdr"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --enable-dependency-tracking
}

src_install() {
	default_src_install
	cd src/python
	python_convert_shebangs 2 *.py
	exeinto /usr/bin
	doexe *.py
}
