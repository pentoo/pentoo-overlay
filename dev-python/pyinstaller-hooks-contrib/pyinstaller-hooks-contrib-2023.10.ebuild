# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Community maintained hooks for PyInstaller"
HOMEPAGE="https://github.com/pyinstaller/pyinstaller-hooks-contrib"

LICENSE="Apache-2.0 GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="test"

# FIXME: flake8?

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
