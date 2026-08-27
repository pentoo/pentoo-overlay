# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Library of web-related functions"
HOMEPAGE="https://github.com/scrapy/w3lib"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	# https://github.com/scrapy/w3lib/issues/164
	'tests/test_url.py::UrlTests::test_add_or_replace_parameter'
	# looks like https://github.com/scrapy/w3lib/issues/90
	'tests/test_url.py::DataURITests::test_mediatype_parameters'
)
distutils_enable_tests pytest
