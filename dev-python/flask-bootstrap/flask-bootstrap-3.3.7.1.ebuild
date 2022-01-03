# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

MY_PN="Flask-Bootstrap"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple integration of Flask and WTForms"
HOMEPAGE="https://pythonhosted.org/Flask-Bootstrap/ https://pypi.org/project/Flask-Bootstrap/"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"
RESTRICT="test"

RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/dominate[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

distutils_enable_sphinx docs
distutils_enable_tests pytest

src_prepare() {
	sed -i -e '/main.txt/,+7d' setup.py || die
	default
}
