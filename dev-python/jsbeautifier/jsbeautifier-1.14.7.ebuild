# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Beautify, unpack or deobfuscate JavaScript"
HOMEPAGE="https://pypi.python.org/pypi/jsbeautifier"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=">=dev-python/six-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/editorconfig-core-py-0.12.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
