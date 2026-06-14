# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Port of Nakatani Shuyo's language-detection library"
HOMEPAGE="https://github.com/Mimino666/langdetect"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"

#distutils_enable_tests pytest
