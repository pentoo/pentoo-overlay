# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A port of node.js's EventEmitter to python."
HOMEPAGE="https://pypi.python.org/pypi/pyee"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
RESTRICT="test"

RDEPEND="
	dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/trio[${PYTHON_USEDEP}]
"

#https://github.com/jfhbrook/pyee/issues/80
PATCHES=( "${FILESDIR}/setup-8.0.1.patch" )
