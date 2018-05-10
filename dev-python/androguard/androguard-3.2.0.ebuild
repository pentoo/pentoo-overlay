# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Read Android's binary format for XML files (AXML) and a decompiler for DEX"
HOMEPAGE="https://pypi.org/project/androguard/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/future
	>=dev-python/networkx-1.11
	dev-python/pygments
	dev-python/lxml
	dev-python/colorama
	dev-python/matplotlib
	>=dev-python/asn1crypto-0.24.0
	$(python_gen_cond_dep '>=dev-python/ipython-5.0[${PYTHON_USEDEP}] <dev-python/ipython-6[${PYTHON_USEDEP}]' python2_7 )
	$(python_gen_cond_dep '>=dev-python/ipython-5.0[${PYTHON_USEDEP}]' python{3_5,3_6} )
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
