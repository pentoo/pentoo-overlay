# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="WebSockets state-machine based protocol implementation"
HOMEPAGE="https://pypi.python.org/pypi/wsproto"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-python/h11-0.7.0[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
