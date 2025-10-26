# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL=1
#DISTUTILS_USE_PEP517=scikit-build-core
DISTUTILS_USE_PEP517=standalone
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 cmake

DESCRIPTION="Library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"
SRC_URI="https://github.com/lief-project/LIEF/archive/${PV}.tar.gz -> ${P}.tar.gz"
#	https://files.pythonhosted.org/packages/cp311/${P:0:1}/${PN}/${P}-cp311-cp311-manylinux_2_28_x86_64.manylinux_2_27_x86_64.whl  -> ${P}_x86_64.zip"
# whl: https://pypi.org/pypi/lief/json
S=${WORKDIR}/LIEF-${PV}

LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="amd64 x86"

IUSE="examples +python static-libs"

# lief requires a forked version of nanobind, see LIEF-0.15.1/api/python/CMakeLists.txt
# So don't try to use a standard one
RDEPEND="python? ( ${PYTHON_DEPS}
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pydantic-core[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	dev-python/xtract[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	python? ( dev-python/scikit-build-core[${PYTHON_USEDEP}] )"
BDEPEND="${DISTUTILS_DEPS}"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
#FIXME: LIEF_TESTS
RESTRICT="test"

QA_PRESTRIPPED="/usr/lib/python3.*/site-packages/lief/_lief.so"

wrap_python() {
	if use python; then
		pushd "./api/python" >/dev/null || die
		distutils-r1_${1} "$@"
		popd >/dev/null
	fi
}

src_prepare() {
	#fix multilib
	sed -i "s|CMAKE_INSTALL_LIBDIR \"lib\"|CMAKE_INSTALL_LIBDIR \"$(get_libdir)\"|" CMakeLists.txt || die
#	sed -i '/COMMAND ${CMAKE_STRIP}/d' CMakeLists.txt || die
#	sed -i "s|\"setup\"|\"scikit_build_core.build\"|" api/python/pyproject.toml || die

	cmake_src_prepare
	wrap_python ${FUNCNAME}
	eapply_user
}

src_configure() {
	#cmake/LIEFOptions.cmake
	local FORCE32=NO
	use x86 && FORCE32=YES

	local PYTHON_API=NO
#	local NANOBIND_DIR

	if use python; then
		#set EPYTHON variable for python_get_sitedir
		python_setup
		PYTHON_API=YES
#		NANOBIND_DIR=$(python_get_sitedir)/nanobind/cmake
	fi

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS="$(usex static-libs OFF ON)"
		-DLIEF_EXAMPLES="$(usex examples ON OFF)"
		-DLIEF_PYTHON_API="$PYTHON_API"

		-DLIEF_MACHO=OFF

#		-DLIEF_PY_LIEF_EXT=ON
#		-DLIEF_PYTHON_STATIC=OFF
#		-DLIEF_PY_LIEF_EXT_SHARED=ON
#		-DBUILD_SHARED_LIBS=ON
#		-DLIEF_FORCE_API_EXPORTS=ON

		-DLIEF_FORCE32="$FORCE32"
	)
#	use python && mycmakeargs+=(
#		-DLIEF_OPT_NANOBIND_EXTERNAL=1
#		-Dnanobind_DIR="${NANOBIND_DIR}"
#	)

	cmake_src_configure
	wrap_python ${FUNCNAME}
}

src_compile() {
	cmake_src_compile
	wrap_python ${FUNCNAME}
}

src_install() {
	cmake_src_install
	wrap_python ${FUNCNAME}
}
