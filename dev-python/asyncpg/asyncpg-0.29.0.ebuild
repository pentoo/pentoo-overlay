# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A fast PostgreSQL Database Client Library for Python/asyncio."
HOMEPAGE="https://github.com/MagicStack/asyncpg"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# ModuleNotFoundError: No module named 'asyncpg.protocol.protocol'
# for some reason, still doesn't work if package is already installed
# or with distutils_install_for_testing function
RESTRICT="test"

BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinxcontrib-asyncio dev-python/sphinx-rtd-theme
