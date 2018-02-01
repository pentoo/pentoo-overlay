# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1 git-r3

DESCRIPTION="Fierce is a DNS reconnaissance tool written in perl"
HOMEPAGE="https://github.com/mschwager/fierce"
EGIT_REPO_URI="https://github.com/mschwager/fierce.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/python-dnspython[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -i -e "s|dnspython==1.15.0|dnspython|" requirements.txt || die
#	#https://github.com/mschwager/fierce/issues/25
#	sed -i -e "s|os.path.dirname(__file__)|\"/usr/share/fierce/\"|" fierce.py || die
#	sed -i -e "s|'lists', data|'share/fierce/lists', data|" setup.py || die
	distutils-r1_python_prepare_all
}
