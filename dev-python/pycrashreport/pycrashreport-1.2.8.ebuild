# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pure python3 for parsing Apple's crash reports"
HOMEPAGE="https://github.com/doronz88/pycrashreport"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	=dev-python/la-panic-0.5.0[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
