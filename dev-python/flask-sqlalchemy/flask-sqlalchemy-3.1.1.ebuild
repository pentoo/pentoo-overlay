# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Adds SQLAlchemy support to Flask"
HOMEPAGE="https://pypi.org/project/flask-sqlalchemy/"
SRC_URI="https://github.com/pallets-eco/flask-sqlalchemy/releases/download/${PV}/flask_sqlalchemy-${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN/-/_}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/flask-2.2.5[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-2.0.16[${PYTHON_USEDEP}]
"

# knew issue in upstream https://github.com/pallets-eco/flask-sqlalchemy/issues/1378
EPYTEST_DESELECT=(
	'tests/test_model_bind.py::test_explicit_table[db2]'
	'tests/test_model_bind.py::test_explicit_table[db4]'
)
EPYTEST_PLUGINS=()
distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/pallets-sphinx-themes \
	dev-python/sphinxcontrib-log-cabinet \
	dev-python/sphinx-issues
