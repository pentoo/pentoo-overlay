# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="Beautify, unpack or deobfuscate JavaScript"
HOMEPAGE="https://pypi.python.org/pypi/jsbeautifier"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=">=dev-python/six-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/editorconfig-0.12.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
