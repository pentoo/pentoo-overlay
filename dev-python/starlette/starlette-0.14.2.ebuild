# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"
DOCS_AUTODOC=1

inherit distutils-r1 docs optfeature

DESCRIPTION="The little ASGI framework that shines"
HOMEPAGE="
	https://www.starlette.io/
	https://github.com/encode/starlette
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

BDEPEND="test? (
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/aiosqlite[${PYTHON_USEDEP}]
	dev-python/databases[${PYTHON_USEDEP}]
	dev-python/graphene[${PYTHON_USEDEP}]
	dev-python/itsdangerous[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/python-multipart[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sse-starlette[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
)"

python_prepare_all() {
	# do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die
	# do not depend on pytest-cov and fail on DeprecationWarning
	rm setup.cfg || die
	# ModuleNotFoundError: No module named 'graphql.execution.executors'
	rm tests/test_graphql.py || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "Required if you want to use FileResponse or StaticFiles" dev-python/aiofiles
	optfeature "Required if you want to use Jinja2Templates" dev-python/jinja
	optfeature "Required if you want to support form parsing, with request.form()" dev-python/python-multipart
	optfeature "Required for SessionMiddleware support." dev-python/itsdangerous
	optfeature "Required for SchemaGenerator support." dev-python/pyyaml
	optfeature "Required for GraphQLApp support" dev-python/graphene
	optfeature "Required if you want to use UJSONResponse." dev-python/ujson
	optfeature "Server Sent Events" dev-python/sse-starlette
}

distutils_enable_tests pytest
