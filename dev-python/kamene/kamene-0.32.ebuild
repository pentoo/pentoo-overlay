# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7} )

IUSE="test"
inherit distutils-r1

DESCRIPTION="Network packet and pcap processing tool, forked from scapy"
HOMEPAGE="https://github.com/phaethon/kamene"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	#do not install compressed man
	sed -e '/data_files/d' -i setup.py || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	unpack "./doc/kamene.1.gz"
	doman kamene.1
}
