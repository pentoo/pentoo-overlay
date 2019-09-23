# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3.0

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Python library and command-line utility for Shodan (https://developer.shodan.io)"
HOMEPAGE="http://github.com/achillean/shodan-python/tree/master https://pypi.org/project/shodan/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-plugins[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.1[${PYTHON_USEDEP}]
	dev-python/xlsxwriter[${PYTHON_USEDEP}]"
DEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
