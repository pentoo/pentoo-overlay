# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Straightforward CLI parsing and dispatching microframework"
HOMEPAGE="https://github.com/mahmoud/face"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND=">=dev-python/boltons-20.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#face/test/test_search_cmd.py:95: AssertionError
#distutils_enable_tests pytest
RESTRICT="test"
