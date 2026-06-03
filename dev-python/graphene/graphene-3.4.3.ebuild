# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="GraphQL Framework for Python"
HOMEPAGE="https://graphene-python.org"
SRC_URI="https://github.com/graphql-python/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/graphql-core-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/graphql-relay-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.7.1[${PYTHON_USEDEP}]
	<dev-python/graphql-core-3.3.0[${PYTHON_USEDEP}]
	<dev-python/graphql-relay-3.3.0[${PYTHON_USEDEP}]
	<dev-python/python-dateutil-3.0.0[${PYTHON_USEDEP}]
	<dev-python/typing-extensions-5.0.0[${PYTHON_USEDEP}]
"

BDEPEND="
	doc? ( app-arch/unzip )
	test? (
		dev-python/iso8601[${PYTHON_USEDEP}]
		dev-python/promise[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/snapshottest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs

python_test() {
	epytest --benchmark-disable \
		--deselect graphene/types/tests/test_schema.py::TestUnforgivingExecutionContext::test_unexpected_error
}
