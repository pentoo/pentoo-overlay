# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="robots.txt parser with support for modern conventions"
HOMEPAGE="https://pypi.org/project/Protego/"

LICENSE="BSD"
KEYWORDS="amd64 arm64 x86"
SLOT="0"
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests pytest
