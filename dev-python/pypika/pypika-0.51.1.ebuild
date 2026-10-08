# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A SQL query builder API for Python"
HOMEPAGE="https://pypi.org/project/PyPika/"
SRC_URI="https://github.com/kayak/pypika/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? ( >=dev-python/parameterized-0.9.0[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/numpydoc dev-python/sphinx-rtd-theme
