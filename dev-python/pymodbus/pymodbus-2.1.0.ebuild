# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A fully featured modbus protocol stack in python"
HOMEPAGE="https://github.com/riptideio/pymodbus/ https://pypi.org/project/pymodbus/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	>=dev-python/pyserial-3.4[${PYTHON_USEDEP}]
	~dev-python/six-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/coverage-4.4[${PYTHON_USEDEP}]
	~dev-python/mock-2.0.0[${PYTHON_USEDEP}]
	~dev-python/nose-1.3.7-r3[${PYTHON_USEDEP}]
	~dev-python/pep8-1.7.0[${PYTHON_USEDEP}]
	"
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
