# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit cmake python-single-r1

DESCRIPTION="a set of GNU Radio blocks/utilities to encode pager messages"
HOMEPAGE="https://github.com/unsynchronized/gr-mixalot"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/unsynchronized/gr-mixalot.git"
	EGIT_BRANCH="main"
else
	COMMIT="09112cbc764d2a622ec5d86e3f9c18e18449758e"
	SRC_URI="https://github.com/unsynchronized/gr-mixalot/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3 public-domain"
SLOT="0"

DEPEND="${PYTHON_DEPS}
		app-text/doxygen
		$(python_gen_cond_dep 'dev-python/numpy:=[${PYTHON_USEDEP}]')
		net-wireless/gnuradio:=
		sci-libs/itpp"
RDEPEND="${DEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DGR_PYTHON_DIR="$(python_get_sitedir)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	#docs are built using automagic logic
	[ -d "${ED}/usr/share/doc/${PN}" ] && mv "${ED}"/usr/share/doc/{"${PN}","${PF}"} || die
	python_optimize
	#rm "${D}/usr/lib/python*/site-packages/gnuradio/mixalot/__init__.py[co]" || die
}
