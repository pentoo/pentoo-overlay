# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python IP address to Autonomous System Number lookup module"
HOMEPAGE="https://github.com/hadiasghari/pyasn"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="test"
