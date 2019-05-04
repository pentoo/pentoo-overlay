# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_5,3_6,3_7} )

inherit cmake-utils distutils-r1
# multilib
# python-r1

HASH_COMMIT="27a03a6fd3169f427fb950293f0863dcd50ac710"

DESCRIPTION="Library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"
SRC_URI="https://github.com/lief-project/LIEF/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples +python"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

S=${WORKDIR}/LIEF-${HASH_COMMIT}

CMAKE_BUILD_TYPE=
#Release

wrap_python() {
	if use python; then
		pushd "${BUILD_DIR}"/api/python >/dev/null || die
		distutils-r1_${1} "$@"
		popd >/dev/null
	fi
}

src_prepare() {
	#fix multilib
	sed -i "s/DESTINATION lib/DESTINATION $(get_libdir)/" CMakeLists.txt || die
	cmake-utils_src_prepare

#	wrap_python ${FUNCNAME}
	default
}

src_compile() {
	cmake-utils_src_compile
	wrap_python ${FUNCNAME}
	default
}

src_configure() {
	use examples && die "unable to compile examples, see https://github.com/lief-project/LIEF/issues/251"

	#cmake/LIEFOptions.cmake
	#if(NOT PYBIND11_CPP_STANDARD AND NOT CMAKE_CXX_STANDARD)
	local FORCE32=NO
	use x86 && FORCE32=YES

	#examples fail to compile
	#https://github.com/lief-project/LIEF/issues/251
	#Do not install python using cmake
	local mycmakeargs=(
		-DLIEF_EXAMPLES="$(usex examples ON OFF)"
		-DLIEF_PYTHON_API="$(usex python)"
		-DLIEF_INSTALL_PYTHON="OFF"
		-DLIEF_FORCE32="$FORCE32"
	)
	cmake-utils_src_configure
	wrap_python ${FUNCNAME}
}

src_install() {
	cmake-utils_src_install
	wrap_python ${FUNCNAME}
}
