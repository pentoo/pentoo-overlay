# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Full featured multi arch/os debugger built on top of PyQt5 and frida"
HOMEPAGE="https://github.com/iGio90/Dwarf"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/capstone-4.0.1[python,${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=virtual/frida-12.8.0[${PYTHON_USEDEP}]
	>=dev-python/pyqt5-5.11.3[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.7.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=""${FILESDIR}"/${PV}-disable_update.patch"
