# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A port of node.js's EventEmitter to python."
HOMEPAGE="https://pypi.python.org/pypi/pyee"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND="
	dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/trio[${PYTHON_USEDEP}]"

#test?
#dev-python/vcversioner[${PYTHON_USEDEP}]"
#        'pytest-runner',
#        'pytest-asyncio
#        'pytest-trio; python_version > "3.7"',

DEPEND="${RDEPEND}"

#https://github.com/jfhbrook/pyee/issues/80
PATCHES=( "${FILESDIR}/setup-8.0.1.patch" )
