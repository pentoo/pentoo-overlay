# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Simple retry client for aiohttp"
HOMEPAGE="
	https://pypi.org/project/aiohttp-retry/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# need a fixture
RESTRICT="test"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]
"
