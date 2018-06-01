# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit python-single-r1

MY_COMMIT="950e56b091504d45ad17ee46ccb4d3950c182d42"

DESCRIPTION="Information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="https://github.com/enjoy-digital/pcie_injector/"
SRC_URI="https://github.com/enjoy-digital/pcie_injector/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="sci-electronics/litex[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]
	sci-electronics/litedram[${PYTHON_USEDEP}]
	sci-electronics/litepcie[${PYTHON_USEDEP}]
	sci-electronics/liteusb[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${MY_COMMIT}

#the following fails, need to be tested with supported hardware
src_compile(){
	${PYTHON} pcie_injector.py
}
