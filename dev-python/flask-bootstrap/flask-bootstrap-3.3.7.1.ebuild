# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Simple integration of Flask and WTForms"
HOMEPAGE="https://pythonhosted.org/Flask-Bootstrap/ https://pypi.org/project/Flask-Bootstrap/"
SRC_URI="https://github.com/mbr/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="test"

RDEPEND="
	>=dev-python/flask-0.8[${PYTHON_USEDEP}]
	dev-python/dominate[${PYTHON_USEDEP}]
	dev-python/visitor[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

distutils_enable_sphinx docs dev-python/alabaster
