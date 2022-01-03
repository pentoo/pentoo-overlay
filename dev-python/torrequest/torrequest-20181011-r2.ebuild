# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Simple Python interface for HTTP(s) requests over Tor"
HOMEPAGE="https://github.com/erdiaker/torrequest"

HASH_COMMIT="8c1b5d0b90bbc5f302cc624a8ae61545542b99f4"
SRC_URI="https://github.com/erdiaker/torrequest/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~mips ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	net-libs/stem[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
