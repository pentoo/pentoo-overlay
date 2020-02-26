# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3.0

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Turn SQLAlchemy DB Model into a graph"
HOMEPAGE="https://github.com/fschulze/sqlalchemy_schemadisplay"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/pydot[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
