# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

MY_COMMIT="93233fe196e8b7063c2293de440976497e4f6dd9"

DESCRIPTION="Small footprint and configurable PCIe core"
HOMEPAGE="https://github.com/enjoy-digital/litepcie"
SRC_URI="https://github.com/enjoy-digital/litepcie/archive/${MY_COMMIT}.zip -> ${P}.zip"

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
