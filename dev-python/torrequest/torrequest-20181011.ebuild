# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="Simple Python interface for HTTP(s) requests over Tor"
HOMEPAGE="https://github.com/erdiaker/torrequest"

HASH_COMMIT="8c1b5d0b90bbc5f302cc624a8ae61545542b99f4"
SRC_URI="https://github.com/erdiaker/torrequest/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
LICENSE="MIT"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	net-libs/stem[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
