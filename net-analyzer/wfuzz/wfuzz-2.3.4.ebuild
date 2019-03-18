# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1 multilib

DESCRIPTION="Wfuzz is a tool designed for bruteforcing Web Applications"
HOMEPAGE="http://www.edge-security.com/wfuzz.php"
SRC_URI="https://github.com/xmendez/wfuzz/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/configparser[${PYTHON_USEDEP}]' python2_7)
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

python_prepare_all() {
	#https://github.com/xmendez/wfuzz/issues/116
	sed -e "s|'configparser',|'configparser;python_version<\"3.5\"',|" -i setup.py || die "sed failed"
	distutils-r1_python_prepare_all
}
