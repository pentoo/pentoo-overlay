# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

DISTUTILS_SINGLE_IMPL=1
inherit eutils distutils-r1

DESCRIPTION="SniffAir framework for wireless pentesting"
HOMEPAGE="https://github.com/Tylous/SniffAir"
MY_PN="SniffAir"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/Tylous/${MY_PN}/archive/V${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"

# dev-python/tabulate and dev-python/pandas — py3 only
#KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	net-wireless/hostapd[wpe]
	$(python_gen_cond_dep '
		dev-python/pandas[${PYTHON_MULTI_USEDEP}]
		dev-python/prettytable[${PYTHON_MULTI_USEDEP}]
		dev-python/tabulate[${PYTHON_MULTI_USEDEP}]
		net-analyzer/scapy[${PYTHON_MULTI_USEDEP}]
	')
	app-crypt/hashcat-utils
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	rm -r module/Auto_EAP/lib/build || die
	default
}

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

	#unbundle hashcat-utils
	rm "${ED}/usr/share/${PN}/module/Handshaker/cap2hccapx.bin" || die
	ln -s /usr/bin/cap2hccapx "${ED}/usr/share/${PN}/module/Handshaker/cap2hccapx.bin"

	python_optimize "${ED}/usr/share/${PN}"
}
