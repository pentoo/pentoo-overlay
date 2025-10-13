# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A binary plist parser/generator for Python"
HOMEPAGE="https://pypi.org/project/biplist/ https://github.com/wooster/biplist"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RESTRICT="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
