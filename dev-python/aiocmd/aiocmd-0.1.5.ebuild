# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Coroutine-based CLI generator using prompt_toolkit"
HOMEPAGE="https://github.com/KimiNewt/aiocmd"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND=">=dev-python/prompt_toolkit-3.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
