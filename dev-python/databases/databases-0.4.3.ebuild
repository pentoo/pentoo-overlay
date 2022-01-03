# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"

inherit distutils-r1 docs optfeature

DESCRIPTION="Async database support for Python."
HOMEPAGE="
	https://www.encode.io/databases/
	https://github.com/encode/databases
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="<dev-python/sqlalchemy-1.4.0[${PYTHON_USEDEP}]"

BDEPEND="test? (
	dev-python/aiopg[${PYTHON_USEDEP}]
	dev-python/aiosqlite[${PYTHON_USEDEP}]
	dev-python/async_timeout[${PYTHON_USEDEP}]
	dev-python/asyncpg[${PYTHON_USEDEP}]
	dev-python/psycopg[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_prepare_all() {
	# do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die
	# fix tests
	sed -i -e '/databases.backends.mysql/d' tests/test_connection_options.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	TEST_DATABASE_URLS="" epytest \
		--deselect tests/test_connection_options.py::test_mysql_pool_size \
		--deselect tests/test_connection_options.py::test_mysql_explicit_pool_size \
		--deselect tests/test_connection_options.py::test_mysql_ssl \
		--deselect tests/test_connection_options.py::test_mysql_explicit_ssl \
		--deselect tests/test_connection_options.py::test_mysql_pool_recycle \
		--deselect tests/test_databases.py \
		--deselect tests/test_integration.py::test_integration
}

pkg_postinst() {
	optfeature "postgresql support" dev-python/asyncpg dev-python/psycopg
	optfeature "mysql support" dev-python/pymysql
	optfeature "sqlite support" dev-python/aiosqlite
	optfeature "postgresql+aiopg support" dev-python/aiopg
}
