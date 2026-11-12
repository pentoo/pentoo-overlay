# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Universal character encoding detector"
HOMEPAGE="
	https://github.com/chardet/chardet/
	https://pypi.org/project/chardet/
"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
