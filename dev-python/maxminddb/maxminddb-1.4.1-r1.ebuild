# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy pypy3 )

inherit distutils-r1

MY_PN="MaxMind-DB-Reader-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python module for reading MaxMind DB files"
HOMEPAGE="https://github.com/maxmind/MaxMind-DB-Reader-python"
SRC_URI="https://github.com/maxmind/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="virtual/python-ipaddress[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	distutils-r1_python_install_all
}
