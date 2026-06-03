# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Relay library for graphql-core-next"
HOMEPAGE="https://github.com/graphql-python/graphql-relay-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/graphql-core[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-{asyncio,describe} )
distutils_enable_tests pytest
