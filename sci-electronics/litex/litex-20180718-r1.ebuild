# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_COMMIT="c314193cc9de483142a65d81ee1517a703bd1851"

DESCRIPTION="Information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="https://github.com/enjoy-digital/litex"
SRC_URI="https://github.com/enjoy-digital/litex/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/${PN}-${MY_COMMIT}
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/pyserial"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
