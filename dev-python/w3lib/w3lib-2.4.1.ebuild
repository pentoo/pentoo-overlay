# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Library of web-related functions"
HOMEPAGE="https://github.com/scrapy/w3lib"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-notfound-page \
	dev-python/sphinx-rtd-theme
