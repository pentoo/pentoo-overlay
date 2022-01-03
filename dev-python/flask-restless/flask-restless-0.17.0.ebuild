# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{9..10} )

MY_PN="Flask-Restless"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="A Flask extension for easy ReSTful API generation"
HOMEPAGE="https://github.com/jfinkels/flask-restless"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/flask-0.10[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-0.8[${PYTHON_USEDEP}]
	>dev-python/python-dateutil-2.2[${PYTHON_USEDEP}]
	>=dev-python/mimerender-0.5.2[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
