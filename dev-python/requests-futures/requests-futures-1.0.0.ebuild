# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="Asynchronous Python HTTP Requests for Humans using Futures"
HOMEPAGE="https://github.com/ross/requests-futures"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
LICENSE="Apache-2.0"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/futures-2.1.3[${PYTHON_USEDEP}]' python2_7)"
