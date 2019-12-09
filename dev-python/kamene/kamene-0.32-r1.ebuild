# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Network packet and pcap processing tool, forked from scapy"
HOMEPAGE="https://github.com/phaethon/kamene"
SRC_URI="https://github.com/phaethon/kamene/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt graphs pyx"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	crypt? ( dev-python/cryptography[idna,${PYTHON_USEDEP}] )
	graphs? ( dev-python/networkx[${PYTHON_USEDEP}] )
	dev-python/dill[${PYTHON_USEDEP}]
	dev-python/ipaddress[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	pyx? ( dev-python/pyx[${PYTHON_USEDEP}] )"

src_unpack() {
	default
	unpack "${S}/doc/kamene.1.gz"
}

python_prepare_all() {
	#do not install compressed man
	sed -e '/data_files/d' -i setup.py || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	doman "${WORKDIR}"/kamene.1
}
