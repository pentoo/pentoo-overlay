# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Fast Base64 implementation"
HOMEPAGE="https://github.com/mayeut/pybase64 https://pypi.org/project/pybase64"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

distutils_enable_sphinx doc \
	dev-python/furo

distutils_enable_tests pytest
