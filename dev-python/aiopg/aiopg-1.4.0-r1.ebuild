# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

MY_PV=${PV/_beta/b}
DESCRIPTION="Postgres integration with asyncio"
HOMEPAGE="
	https://aiopg.readthedocs.io
	https://github.com/aio-libs/aiopg
"
SRC_URI="https://github.com/aio-libs/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# tests use docker containers -- that's wild!
RESTRICT="test"

RDEPEND="
	dev-python/async-timeout[${PYTHON_USEDEP}]
	dev-python/psycopg:2[${PYTHON_USEDEP}]
"

DEPEND="test? (
	dev-python/docker-py[${PYTHON_USEDEP}]
	dev-python/pytest-timeout[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
)"

DOCS=( CHANGES.txt README.rst )

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinxcontrib-asyncio

python_test() {
	epytest --no-pull
}

pkg_postinst() {
	optfeature "sqlalchemy support" dev-python/sqlalchemy
	einfo "<dev-python/sqlalchemy-2.0.0"
}
