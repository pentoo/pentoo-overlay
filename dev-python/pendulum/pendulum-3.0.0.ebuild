# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python datetimes made easy."
HOMEPAGE="https://pendulum.eustace.io/"

LICENSE="MIT"
SLOT="0"
#fixe GO deps
#KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/python-dateutil-2.6[${PYTHON_USEDEP}]
	>=dev-python/pytzdata-2020.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
