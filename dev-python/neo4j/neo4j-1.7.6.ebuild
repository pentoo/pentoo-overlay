# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Neo4j Bolt driver for Python"
HOMEPAGE="https://github.com/neo4j/neo4j-python-driver"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/neobolt-1.7.15[${PYTHON_USEDEP}]
	>=dev-python/neotime-1.7.1[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"
