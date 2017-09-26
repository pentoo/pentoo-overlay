# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Beautify, unpack or deobfuscate JavaScript"
HOMEPAGE="https://pypi.python.org/pypi/jsbeautifier"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/six-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/editorconfig-0.12.0[${PYTHON_USEDEP}]
"
