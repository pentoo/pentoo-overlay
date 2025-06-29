# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for reading and writing Windows shortcut files"
HOMEPAGE="https://sourceforge.net/projects/pylnk/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="${RDEPEND}"

RESTRICT="test"
#tests fails
#distutils_enable_tests pytest
