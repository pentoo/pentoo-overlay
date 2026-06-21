# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python parser for kdebug events"
HOMEPAGE="https://github.com/matan1008/pykdebugparser"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

PATCHES=(
	"${FILESDIR}"/${P}-fix-pyproject.patch
)

RDEPEND="
	dev-python/construct[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
