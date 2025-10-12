# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="conversions between Python values and C bit field structs"
HOMEPAGE="https://github.com/eerimoq/bitstruct"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="test"

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
