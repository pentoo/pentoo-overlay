# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="provides a collection of utilities for working with Excel files"
HOMEPAGE="https://pypi.org/project/xlutils/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
RESTRICT="test"

RDEPEND="
	>=dev-python/xlwt-1.3[${PYTHON_USEDEP}]
	>=dev-python/xlrd-1.2[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"
