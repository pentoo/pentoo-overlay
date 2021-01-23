# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/liftoff/${PN}

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Pyminifier is a Python code minifier, obfuscator, and compressor."
HOMEPAGE="https://github.com/liftoff/pyminifier"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
