# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

MY_COMMIT="23d6a6840d4276f8d1a7f31bafb8d0aaaecff6d1"

DESCRIPTION="Small footprint and configurable USB core"
HOMEPAGE="https://github.com/enjoy-digital/liteusb"
SRC_URI="https://github.com/enjoy-digital/liteusb/archive/${MY_COMMIT}.zip -> ${P}.zip"

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
	rm -r test
	eapply_user
}
