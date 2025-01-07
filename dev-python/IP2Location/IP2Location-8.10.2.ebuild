# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python API for IP2Location database"
HOMEPAGE="https://pypi.org/project/IP2Location/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
RESTRICT="test"
