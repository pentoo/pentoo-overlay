# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Adds read support for dbf files to agate"
HOMEPAGE="https://agate-dbf.readthedocs.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~mips ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/dbfread[${PYTHON_USEDEP}]"
