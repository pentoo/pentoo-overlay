# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Neo4j Bolt driver for Python"
HOMEPAGE="https://github.com/neo4j/neo4j-python-driver"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.21.2[${PYTHON_USEDEP}]
	<dev-python/numpy-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.1.0[${PYTHON_USEDEP}]
	<dev-python/pandas-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyarrow-6.0.0[${PYTHON_USEDEP}]
	<dev-python/pyarrow-25.0.0[${PYTHON_USEDEP}]
"
