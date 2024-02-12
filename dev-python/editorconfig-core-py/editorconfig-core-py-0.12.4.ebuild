# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
inherit cmake distutils-r1

TESTVER="abb579e00f2deeede91cb485e53512efab9c6474"
DESCRIPTION="Clone of EditorConfig core written in Python"
HOMEPAGE="https://editorconfig.org/"
SRC_URI="https://github.com/${PN%-core-py}/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	test? (
		https://github.com/${PN%-core-py}/${PN%-core-py}-core-test/archive/${TESTVER}.tar.gz -> ${PN%-core-py}-core-test-${TESTVER}.gh.tar.gz
	)"

LICENSE="PYTHON BSD-4"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="cli test"
RESTRICT="!test? ( test )"

RDEPEND="
	cli? ( !app-text/editorconfig-core-c[cli] )"

src_prepare() {
	if use test; then
		mv "${WORKDIR}"/${PN%-core-py}-core-test-${TESTVER}/* "${S}"/tests || die
	fi
	if ! use cli; then
		sed -i -e '/editorconfig\.__main__/d' setup.py || die
	fi

	cmake_src_prepare
	distutils-r1_src_prepare
}

python_test() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
	)

	cmake_src_configure
	cmake_src_compile
	cmake_src_test
}
