# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Web framework and asynchronous networking library"
HOMEPAGE="http://www.tornadoweb.org/en/stable/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#	>dev-python/sphinx-1.8.2[${PYTHON_USEDEP}]
RDEPEND="
	>dev-python/sphinx-1.7.5[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-asyncio[${PYTHON_USEDEP}]
	dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
