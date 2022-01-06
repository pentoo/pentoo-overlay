# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A python library for using the MISP Rest API"
HOMEPAGE="https://github.com/MISP/PyMISP"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="BSD"
SLOT="0"
IUSE="doc"
RESTRICT="test"

CDEPEND="${PYTHON_DEPS}"
RDEPEND="${CDEPEND}
	>=dev-python/deprecated-1.2.13[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.26.0[${PYTHON_USEDEP}]
"

DEPEND="${CDEPEND}
	doc? (
		dev-python/sphinx
		dev-python/sphinx-autodoc-typehints
		dev-python/recommonmark )
	test? (
		dev-python/python-magic
		dev-python/requests-mock )"

#src_test() {
	# FIXME (20191022-2.4.117): maybe it wrong i dont know
	# test_object_level_tag (tests.test_mispevent.TestMISPEvent) ... 
	# skipped 'Not supported on MISP: https://github.com/MISP/MISP/issues/2638 - https://github.com/MISP/PyMISP/issues/168'
#	esetup.py test || die
#}

distutils_enable_tests pytest

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
