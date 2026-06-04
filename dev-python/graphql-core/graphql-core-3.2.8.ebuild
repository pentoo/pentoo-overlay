# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="GraphQL for Python"
HOMEPAGE="https://github.com/graphql-python/graphql-core"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=( pytest-{asyncio,describe,timeout} )
# no need to benchmark the tool
EPYTEST_IGNORE=(
	tests/benchmarks
)
distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_test() {
	sed -i -e '/^addopts/d' setup.cfg
	epytest --run-slow
}
