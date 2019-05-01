# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="A python library enabling python developers to manipulate nmap process and data"
HOMEPAGE="https://pypi.org/project/python-libnmap/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="CC-BY-3.0"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/boto[${PYTHON_USEDEP}]"
