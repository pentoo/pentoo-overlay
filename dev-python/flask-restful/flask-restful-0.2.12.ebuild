# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="Flask-RESTful"
PYPI_NO_NORMALIZE=1

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Flask-RESTful provides the building blocks for creating a great REST API"
HOMEPAGE="https://github.com/flask-restful/flask-restful"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${DEPEND}
	>=dev-python/aniso8601-0.82[${PYTHON_USEDEP}]
	>=dev-python/flask-0.8[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
"
