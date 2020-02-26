# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="A generator library for concise, unambiguous and URL-safe UUIDs."
HOMEPAGE="https://github.com/stochastic-technologies/shortuuid https://pypi.python.org/pypi/shortuuid"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pep8[${PYTHON_USEDEP}] )"

DOCS="README.rst"

src_install() {
	distutils-r1_src_install

	delete_tests() {
		rm "${ED}$(python_get_sitedir)/shortuuid/tests.py"
	}
	python_foreach_impl delete_tests
}
