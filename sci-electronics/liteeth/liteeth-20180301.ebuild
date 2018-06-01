# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

MY_COMMIT="95849a0fed26c2f7e88e731e8ba7cb6b95d873e8"

DESCRIPTION="Small footprint and configurable Ethernet core"
HOMEPAGE="https://github.com/enjoy-digital/liteeth"
SRC_URI="https://github.com/enjoy-digital/liteeth/archive/${MY_COMMIT}.zip -> ${P}.zip"

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
	rm test/__init__.py example_designs/__init__.py
	eapply_user
}
