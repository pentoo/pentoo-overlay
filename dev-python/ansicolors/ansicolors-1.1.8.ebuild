# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Add ANSI colors and decorations to your strings"
HOMEPAGE="
	https://pypi.org/project/ansicolors/
"

SRC_URI="https://files.pythonhosted.org/packages/source/a/ansicolors/${P}.zip"
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
BDEPEND="app-arch/unzip"

distutils_enable_tests pytest
