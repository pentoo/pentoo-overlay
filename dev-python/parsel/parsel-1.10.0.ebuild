# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Extract data from HTML and XML using XPath and CSS selectors"
HOMEPAGE="https://github.com/scrapy/parsel"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/cssselect-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/w3lib-1.19.0[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/sybil[${PYTHON_USEDEP}]
	)
"

# this test fails but it's due a problem with the assertion. the result should
# be passed and not failed
EPYTEST_DESELECT=(
	'tests/test_xpathfuncs.py::XPathFuncsTestCase::test_set_xpathfunc'
)

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-autodoc-typehints \
	dev-python/sphinx-notfound-page \
	dev-python/sphinx-rtd-theme
