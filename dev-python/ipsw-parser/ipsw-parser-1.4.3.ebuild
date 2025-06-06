# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Utility for parsing and extracting data from IPSW"
HOMEPAGE="https://github.com/doronz88/ipsw_parser"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND=">=dev-python/construct-2.9.29[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
	dev-python/plumbum[${PYTHON_USEDEP}]
	>=dev-python/pyimg4-0.8.8[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/remotezip2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
