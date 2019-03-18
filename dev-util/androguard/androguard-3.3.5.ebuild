# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Read Android's binary format for XML files (AXML) and a decompiler for DEX"
HOMEPAGE="https://github.com/androguard/androguard"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/future[${PYTHON_USEDEP}]
	>=dev-python/networkx-1.11[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-0.24.0[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/pydot-1.4.1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/ipython-5.0[${PYTHON_USEDEP}] <dev-python/ipython-6[${PYTHON_USEDEP}]' python2_7 )
	$(python_gen_cond_dep '>=dev-python/ipython-5.0[${PYTHON_USEDEP}]' python{3_5,3_6} )
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
