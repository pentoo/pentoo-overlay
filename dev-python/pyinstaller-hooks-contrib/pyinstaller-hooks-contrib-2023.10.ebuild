# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Community maintained hooks for PyInstaller"
HOMEPAGE="https://github.com/pyinstaller/pyinstaller-hooks-contrib"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RESTRICT="test"

RDEPEND=""
# FIXME: flake8?

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
