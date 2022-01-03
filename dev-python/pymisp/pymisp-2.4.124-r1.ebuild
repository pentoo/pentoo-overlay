# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A python library for using the MISP Rest API"
HOMEPAGE="https://github.com/MISP/PyMISP"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~mips ~x86"
LICENSE="BSD"
SLOT="0"
IUSE="doc test"

CDEPEND="${PYTHON_DEPS}"
RDEPEND="${CDEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/py2neo[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	dev-python/deprecated[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/validators[${PYTHON_USEDEP}]"

DEPEND="${CDEPEND}
	doc? (
		dev-python/sphinx
		dev-python/sphinx-autodoc-typehints
		dev-python/recommonmark )
	test? (
		dev-python/python-magic
		dev-python/requests-mock )"

src_test() {
	# FIXME (20191022-2.4.117): maybe it wrong i dont know
	# test_object_level_tag (tests.test_mispevent.TestMISPEvent) ... 
	# skipped 'Not supported on MISP: https://github.com/MISP/MISP/issues/2638 - https://github.com/MISP/PyMISP/issues/168'
	esetup.py test || die
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		pushd docs/ >/dev/null || die

#unable to reproduce
#		emake -j1 man html

		doman build/man/pymisp.1
		dodoc -r build/html

		popd >/dev/null || die
	fi
}
