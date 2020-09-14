# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="A port of node.js's EventEmitter to python."
HOMEPAGE="https://pypi.python.org/pypi/pyee"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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

#https://github.com/jfhbrook/pyee/pull/73/files
PATCHES=( "${FILESDIR}/setup.patch" )
