# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_COMMIT="d919f90cf6eb615b524fa0e74c5a9b15096603aa"

DESCRIPTION="Small footprint and configurable embedded FPGA logic analyzer"
HOMEPAGE="https://github.com/enjoy-digital/litescope"
SRC_URI="https://github.com/enjoy-digital/litescope/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/${PN}-${MY_COMMIT}
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="sci-electronics/litex[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	rm test/__init__.py example_designs/__init__.py
	eapply_user
}
