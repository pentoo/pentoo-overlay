# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 cmake

DESCRIPTION="tiny and efficient C++/Python bindings"
HOMEPAGE="https://github.com/wjakob/nanobind"
SRC_URI="https://github.com/wjakob/nanobind/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-cpp/robin-map"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_test(){
	#cmake_src_test
	cmake_build
}

src_prepare(){
	#FIXME unbundle robin-map using NB_USE_SUBMODULE_DEPS in the next version
	#https://github.com/wjakob/nanobind/issues/410
	#fool cmake script to use external module
	mkdir -p ext/robin_map/include

	if use test; then
		cmake_src_prepare
	fi
	distutils-r1_src_prepare
	eapply_user
}

src_configure(){
	if use test; then
		einfo "==== running configure test"
		local mycmakeargs=(
			-DNB_TEST=ON
			-DNB_TEST_STABLE_ABI=ON
		)
		cmake_src_configure
	fi
	distutils-r1_src_configure
}

src_compile(){
	distutils-r1_src_compile
}

src_install(){
	distutils-r1_src_install
}
