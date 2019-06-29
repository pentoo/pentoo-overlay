# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_5,3_6,3_7} )

inherit cmake-utils distutils-r1

HASH_COMMIT="826965be1b23f8e1c48efdacd3b6f96c2fc714f7"

DESCRIPTION="Library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"
SRC_URI="https://github.com/lief-project/LIEF/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples +python static-libs"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CMAKE_BUILD_TYPE=

S=${WORKDIR}/LIEF-${HASH_COMMIT}

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
	#cmake/LIEFOptions.cmake
	local FORCE32=NO
	use x86 && FORCE32=YES

	#Do not install python using cmake
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS="$(usex static-libs OFF ON)"
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
