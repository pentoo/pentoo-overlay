# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="A python library for using the MISP Rest API"
HOMEPAGE="https://github.com/MISP/PyMISP"
SRC_URI="https://github.com/MISP/PyMISP/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~mips ~x86"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]"

S="${WORKDIR}"/PyMISP-${PV}
