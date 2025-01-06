# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Validate STIX 2 Patterns"
HOMEPAGE="https://github.com/oasis-open/cti-pattern-validator"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="test"

#FIXME: antlr4-python3-runtime has no python 3.12 target yet
RDEPEND="
	dev-python/antlr4-python3-runtime[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
