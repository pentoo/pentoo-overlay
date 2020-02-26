# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit cmake python-single-r1

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bistromath/gr-air-modes.git"
	EGIT_BRANCH="master"
else
	#snapshot
	HASH_COMMIT="a2f2627c5421368b8af1b57ca9818e1c79d4f4f0"
	SRC_URI="https://github.com/bistromath/gr-air-modes/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

DESCRIPTION="This module implements a complete Mode S and ADS-B receiver for Gnuradio"
HOMEPAGE="https://github.com/bistromath/gr-air-modes"

LICENSE="GPL-3"
SLOT="0"
IUSE="fgfs rtlsdr uhd"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pyzmq[${PYTHON_MULTI_USEDEP}]')
	>=net-wireless/gnuradio-3.8.0.0:=
	net-wireless/gr-osmosdr
	fgfs? (
		games-simulation/flightgear
		sci-libs/scipy
	)
	rtlsdr? ( net-wireless/rtl-sdr )
	uhd? ( >=net-wireless/uhd-3.4.0 )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
	python_fix_shebang "${S}"
}

src_compile() {
	cmake_src_compile -j1
}

src_install() {
	cmake_src_install
}
