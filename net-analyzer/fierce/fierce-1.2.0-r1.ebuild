# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

DESCRIPTION="A DNS reconnaissance tool for locating non-contiguous IP space"
HOMEPAGE="https://github.com/mschwager/fierce"
SRC_URI="https://github.com/mschwager/fierce/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="virtual/python-dnspython[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -i -e "s|dnspython==1.15.0|dnspython|" requirements.txt || die
	#https://github.com/mschwager/fierce/issues/25
	sed -i -e "s|os.path.dirname(__file__)|\"/usr/share/fierce/\"|" fierce.py || die
	sed -i -e "s|'lists', data|'share/fierce/lists', data|" setup.py || die
	distutils-r1_python_prepare_all
}
