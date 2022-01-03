# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Neo4j Bolt driver for Python"
HOMEPAGE="https://github.com/neo4j/neo4j-python-driver"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"

RDEPEND="dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

#FIXME ModuleNotFoundError: No module named 'neo4j.bolt
#https://github.com/neo4j/neo4j-python-driver/issues/482
