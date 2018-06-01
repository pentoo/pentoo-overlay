# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

MY_COMMIT="d919f90cf6eb615b524fa0e74c5a9b15096603aa"

DESCRIPTION="Small footprint and configurable embedded FPGA logic analyzer"
HOMEPAGE="https://github.com/enjoy-digital/litescope"
SRC_URI="https://github.com/enjoy-digital/litescope/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

RDEPEND="sci-electronics/litex[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${PN}-${MY_COMMIT}

src_prepare(){
#	sed -i -e '/test_suite/d' setup.py
	rm -r test example_designs
	eapply_user
}
