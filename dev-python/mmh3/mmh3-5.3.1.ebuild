# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="Python extension for MurmurHash3, a set of fast and robust hash functions"
HOMEPAGE="
	https://pypi.org/project/mmh3/
"
SRC_URI="https://github.com/hajimes/mmh3/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~s390 ~x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

# missing a package for the theme
#distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/myst-parser
