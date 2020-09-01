# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit cmake python-single-r1 git-r3

DESCRIPTION="a set of GNU Radio blocks/utilities to encode pager messages"
HOMEPAGE="https://github.com/ckoval7/gr-mixalot.git"
EGIT_REPO_URI="https://github.com/ckoval7/gr-mixalot.git"

LICENSE="GPL-3 public-domain"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
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
