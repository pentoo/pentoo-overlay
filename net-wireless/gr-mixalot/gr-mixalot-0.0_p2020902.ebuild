# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit cmake python-single-r1

DESCRIPTION="a set of GNU Radio blocks/utilities to encode pager messages"
HOMEPAGE="https://github.com/ckoval7/gr-mixalot.git"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ckoval7/gr-mixalot.git"
	EGIT_BRANCH="maint-3.8"
else
	COMMIT="565728a16d3a53b5d2ccef63b271c0f6b032481f"
	SRC_URI="https://github.com/ckoval7/gr-mixalot/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3 public-domain"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
		app-doc/doxygen
		=net-wireless/gnuradio-3.8*
		sci-libs/itpp:="
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
	sed -i '/swig_lib_target/s/${CMAKE_INSTALL_PREFIX}\///' swig/CMakeLists.txt || die
}

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
}
