# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Easy-to-use data handling for SQL data stores"
HOMEPAGE="https://github.com/pudo/dataset"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	<dev-python/sqlalchemy-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/alembic-0.6.2[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs dev-python/furo

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
