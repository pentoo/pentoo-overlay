# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

MY_COMMIT="c23814961d71ab6508c855db3c643b71d8990e8c"

DESCRIPTION="Small footprint and configurable DRAM core"
HOMEPAGE="https://github.com/enjoy-digital/litedram"
SRC_URI="https://github.com/enjoy-digital/litedram/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/${PN}-${MY_COMMIT}
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="sci-electronics/litex[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	rm test/__init__.py
	eapply_user
}
