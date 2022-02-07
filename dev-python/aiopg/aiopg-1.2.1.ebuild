# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1 optfeature

DESCRIPTION="aiopg is a library for accessing a PostgreSQL database from the asyncio"
HOMEPAGE="
	https://aiopg.readthedocs.io
	https://github.com/aio-libs/aiopg
"
SRC_URI="https://github.com/aio-libs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# tests seem to be wanting to send/recieve things
# which is probably not allowed inside emerge so they fail?
RESTRICT="test"

RDEPEND="dev-python/psycopg[${PYTHON_USEDEP}]"

DEPEND="test? (
	dev-python/pytest-timeout[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
)"

pkg_postinst() {
	optfeature "sqlalchemy support" dev-python/sqlalchemy
}

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinxcontrib-asyncio
