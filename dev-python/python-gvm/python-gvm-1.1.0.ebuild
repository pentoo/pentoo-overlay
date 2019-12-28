# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Library to communicate with remote servers over GMP or OSP"
HOMEPAGE="https://github.com/greenbone/python-gvm"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~mips ~x86"
LICENSE="GPL-3+"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]"
