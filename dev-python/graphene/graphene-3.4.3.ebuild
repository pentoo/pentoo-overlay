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

EPYTEST_PLUGINS=( pytest-{asyncio,mock} )
# benchmark
EPYTEST_DESELECT=(
	'graphene/types/tests/test_objecttype.py::test_objecttype_container_benchmark'
	'graphene/types/tests/test_query.py::test_big_list_query_benchmark'
	'graphene/types/tests/test_query.py::test_big_list_query_compiled_query_benchmark'
	'graphene/types/tests/test_query.py::test_big_list_of_containers_query_benchmark'
	'graphene/types/tests/test_query.py::test_big_list_of_containers_multiple_fields_query_benchmark'
	'graphene/types/tests/test_query.py::test_big_list_of_containers_multiple_fields_custom_resolvers_query_benchmark'
)
distutils_enable_tests pytest
