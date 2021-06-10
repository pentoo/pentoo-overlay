# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9})

inherit cmake python-single-r1

DESCRIPTION="gnuradio I/Q balancing"
HOMEPAGE="http://git.osmocom.org/gr-iqbal/"

HASH_COMMIT="f56d917c83074ed93e9b47071b8f3a695796f0d8"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/osmocom/gr-iqbal.git"
else
	SRC_URI="https://github.com/osmocom/gr-iqbal/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE="doc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="=net-wireless/gnuradio-3.8*:0=[${PYTHON_SINGLE_USEDEP}]
	net-libs/libosmo-dsp:=
	dev-libs/boost:=
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_DOXYGEN="$(usex doc)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	python_optimize
}
