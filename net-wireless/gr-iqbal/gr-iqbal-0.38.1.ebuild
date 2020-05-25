# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit cmake cmake-utils python-single-r1

DESCRIPTION="gnuradio I/Q balancing"
HOMEPAGE="http://git.osmocom.org/gr-iqbal/"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://git.osmocom.org/gr-iqbal"
	KEYWORDS=""
else
	SRC_URI="https://github.com/osmocom/gr-iqbal/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE="doc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=net-wireless/gnuradio-3.8.0.0:=[${PYTHON_SINGLE_USEDEP}]
	net-libs/libosmo-dsp:=
	dev-libs/boost:="
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_DOXYGEN="$(usex doc)"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake_src_install
	python_optimize "${ED}/$(python_get_sitedir)"
}
