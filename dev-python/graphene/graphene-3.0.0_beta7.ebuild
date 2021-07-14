# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="GraphQL Framework for Python"
HOMEPAGE="https://graphene-python.org
	https://pypi.org/project/graphene
	https://github.com/graphql-python/graphene
"
SRC_URI="https://github.com/graphql-python/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	doc? ( https://graphene-python.org/sphinx_graphene_theme.zip -> sphinx-${P}.zip )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/aniso8601[${PYTHON_USEDEP}]
	dev-python/graphql-core[${PYTHON_USEDEP}]
	dev-python/graphql-relay[${PYTHON_USEDEP}]
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

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

distutils_enable_sphinx docs

src_unpack() {
	unpack ${P}.tar.gz

	if use doc ; then
		unpack sphinx-${P}.zip
		mv "${WORKDIR}"/sphinx_graphene_theme "${S}"/docs || die
	fi
}

python_test() {
	epytest --benchmark-disable \
		--deselect graphene/types/tests/test_schema.py::TestUnforgivingExecutionContext::test_unexpected_error
}
