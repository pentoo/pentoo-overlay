# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A Python library/CLI tool for parsing Apple's Image4 format"
HOMEPAGE="https://github.com/m1stadev/PyIMG4"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND=">=dev-python/asn1-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.7[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.18.0[${PYTHON_USEDEP}]
	dev-python/lzfse[${PYTHON_USEDEP}]
	dev-python/pylzss[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/poetry-dynamic-versioning[${PYTHON_USEDEP}]
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
