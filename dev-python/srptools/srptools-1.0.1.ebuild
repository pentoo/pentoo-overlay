# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Tools to implement Secure Remote Password (SRP) authentication"
HOMEPAGE="https://github.com/idlesign/srptools"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

#distutils_enable_tests pytest
