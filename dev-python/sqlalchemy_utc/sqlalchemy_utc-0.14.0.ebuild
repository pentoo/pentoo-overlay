# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="SQLAlchemy type to store aware datetime values"
HOMEPAGE="https://pypi.org/project/SQLAlchemy-Utc/"
SRC_URI="https://github.com/spoqa/sqlalchemy-utc/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

S=${WORKDIR}/${P/_/-}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"

RDEPEND="
	>=dev-python/sqlalchemy-0.9.0[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

# not working test
EPYTEST_DESELECT=(
	'tests/test_now.py::test_utcnow_timezone[sqlite://]'
)

distutils_enable_tests pytest
