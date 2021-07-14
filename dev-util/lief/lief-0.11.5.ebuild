# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit cmake distutils-r1

DESCRIPTION="Library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"
SRC_URI="https://github.com/lief-project/LIEF/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="examples +python static-libs"

RDEPEND="python? ( ${PYTHON_DEPS}
	dev-python/xtract[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# linxon: WHY??
CMAKE_BUILD_TYPE=

S=${WORKDIR}/LIEF-${PV}

wrap_python() {
	if use python; then
#		pushd "${BUILD_DIR}"/api/python >/dev/null || die
		distutils-r1_${1} "$@"
#		popd >/dev/null
	fi
}

src_prepare() {
	#fix multilib
	sed -i "s/DESTINATION lib/DESTINATION $(get_libdir)/" CMakeLists.txt || die
	cmake_src_prepare
	wrap_python ${FUNCNAME}
}

src_configure() {
	#cmake/LIEFOptions.cmake
	local FORCE32=NO
	use x86 && FORCE32=YES

	#Do not install python using cmake
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS="$(usex static-libs OFF ON)"
		-DLIEF_EXAMPLES="$(usex examples ON OFF)"
		-DLIEF_PYTHON_API=off
		-DLIEF_INSTALL_PYTHON="OFF"
		-DLIEF_FORCE32="$FORCE32"
	)
	cmake_src_configure
	wrap_python ${FUNCNAME}
}

src_compile() {
	cmake_src_compile

#	wrap_python ${FUNCNAME}
	compile_python() {
#		${EPYTHON} setup.py build_ext
		distutils-r1_python_compile build_ext
	}
	python_foreach_impl compile_python

}

src_install() {
	cmake_src_install
	wrap_python ${FUNCNAME}
}
