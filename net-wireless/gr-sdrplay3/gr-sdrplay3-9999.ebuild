# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit cmake python-single-r1

DESCRIPTION="GNU Radio OOT module for SDRplay RSP devices - SRDPlay API v3"
HOMEPAGE="https://github.com/fventuri/gr-sdrplay3"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fventuri/gr-sdrplay3.git"
else
	SRC_URI="https://github.com/fventuri/gr-sdrplay3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64 ~arm ~riscv ~x86"
fi

LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE="doc python"

RDEPEND="${PYTHON_DEPS}
	dev-libs/boost:=
	>=net-wireless/sdrplay-3.0
	net-wireless/gnuradio:0=[${PYTHON_SINGLE_USEDEP}]
	"
DEPEND="${RDEPEND}"

BDEPEND="$(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]')
	doc? ( app-text/doxygen )
	"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DENABLE_PYTHON="$(usex python ON OFF)"
		-DENABLE_DOXYGEN="$(usex doc ON OFF)"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use python; then
		find "${ED}" -name '*.py[oc]' -delete || die
		python_optimize
	fi
}
