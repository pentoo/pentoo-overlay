# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Turn SQLAlchemy DB Model into a graph"
HOMEPAGE="https://github.com/fschulze/sqlalchemy_schemadisplay"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	<dev-python/sqlalchemy-3.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-2.0[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pydot[${PYTHON_USEDEP}]
"
