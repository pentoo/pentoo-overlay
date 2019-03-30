# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
#https://github.com/PiotrDabkowski/Js2Py/issues/106
#{2_7,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Pentester's Tools Parser"
HOMEPAGE="https://pypi.python.org/pypi/PTP"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/Js2Py[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	rm -r tests/
	eapply_user
}
