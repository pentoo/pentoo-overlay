# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1
inherit eutils python-single-r1 distutils-r1

DESCRIPTION="SniffAir framework for wireless pentesting"
HOMEPAGE="https://github.com/Tylous/SniffAir"
MY_PN="SniffAir"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/Tylous/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	net-wireless/hostapd[wpe]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

src_compile() {
	pushd module/Auto_EAP/lib
	distutils-r1_src_compile
	popd
}

src_install() {
	pushd module/Auto_EAP/lib
	distutils-r1_src_install
	popd

	# install the rest of the files
	dodir /usr/share/${PN}/

	cp -R * "${ED}"/usr/share/${PN}/
	python_fix_shebang "${ED}"/usr/share/${PN}
	make_wrapper "${PN}" /usr/share/"${PN}"/SniffAir.py /usr/share/"${PN}"
}
