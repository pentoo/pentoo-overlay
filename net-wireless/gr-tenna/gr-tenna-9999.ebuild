# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
inherit cmake python-single-r1

DESCRIPTION="goTenna Mesh protocol in GNU Radio."
HOMEPAGE="https://github.com/argilo/gr-tenna"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/argilo/gr-tenna.git"
else
	COMMIT="90f026d586afbb9a6ad4a06840367126210d8a0b"
	SRC_URI="https://github.com/argilo/gr-tenna/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3 public-domain"
SLOT="0"

DEPEND="${PYTHON_DEPS}
	net-wireless/gnuradio"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/reedsolo[${PYTHON_USEDEP}]')"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DGR_PYTHON_DIR="$(python_get_sitedir)"
		-DENABLE_DOXYGEN="OFF"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	python_optimize
}
