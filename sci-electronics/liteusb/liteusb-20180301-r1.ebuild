# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_COMMIT="23d6a6840d4276f8d1a7f31bafb8d0aaaecff6d1"

DESCRIPTION="Small footprint and configurable USB core"
HOMEPAGE="https://github.com/enjoy-digital/liteusb"
SRC_URI="https://github.com/enjoy-digital/liteusb/archive/${MY_COMMIT}.zip -> ${P}.zip"

S=${WORKDIR}/${PN}-${MY_COMMIT}
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="app-arch/unzip"
RDEPEND="sci-electronics/litex[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	rm test/__init__.py
	eapply_user
}
