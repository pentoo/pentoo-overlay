# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A SQL query builder API for Python"
HOMEPAGE="https://pypi.org/project/PyPika/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

#RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
