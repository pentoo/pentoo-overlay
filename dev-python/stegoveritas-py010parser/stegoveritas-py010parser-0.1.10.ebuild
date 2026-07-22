# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="A modified pycparser to parse 010 templates"
HOMEPAGE="https://github.com/d0c-s4vage/pfp"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}
	!!dev-python/py010parser
	dev-python/six[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

distutils_enable_tests pytest
