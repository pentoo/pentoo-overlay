# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

#MY_PN="flask-restx"
#MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="Fully featured framework for fast, easy and documented API development"
HOMEPAGE="https://github.com/python-restx/flask-restx"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND="dev-python/aniso8601[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	>=dev-python/flask-0.10[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
