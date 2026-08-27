# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A python implementation for GNU utils"
HOMEPAGE="https://github.com/matan1008/pygnuutils"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
