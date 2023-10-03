# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=poetry
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )
#PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Magic filter based on dynamic attribute getter"
HOMEPAGE="https://github.com/aiogram/magic-filter/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RESTRICT="test"

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
