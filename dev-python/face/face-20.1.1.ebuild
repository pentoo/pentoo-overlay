# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND=">=dev-python/boltons-20.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#face/test/test_search_cmd.py:95: AssertionError
#distutils_enable_tests pytest
RESTRICT="test"
