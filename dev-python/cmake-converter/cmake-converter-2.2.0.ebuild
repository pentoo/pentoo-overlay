# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="CMake converter for Visual Studio projects"
HOMEPAGE="https://github.com/pavelliavonau/cmakeconverter"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no test in pypi package

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
