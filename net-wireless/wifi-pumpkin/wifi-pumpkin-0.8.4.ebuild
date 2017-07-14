# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="WiFi-Pumpkin"

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 multilib

DESCRIPTION="Framework for Rogue Wi-Fi Access Point Attack"
HOMEPAGE="https://github.com/P0cL4bs/WiFi-Pumpkin"
SRC_URI="https://github.com/P0cL4bs/WiFi-Pumpkin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="plugins"

RDEPEND="${PYTHON_DEPS}
	net-wireless/hostapd
	net-wireless/rfkill
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-python/twisted-web[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/python-nmap[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/config[${PYTHON_USEDEP}]
	virtual/python-dnspython[${PYTHON_USEDEP}]
	dev-python/isc_dhcp_leases[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/pcapy[${PYTHON_USEDEP}]
	dev-python/configparser[${PYTHON_USEDEP}]
	dev-python/netfilterqueue[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	>=dev-python/libarchive-c-2.1[${PYTHON_USEDEP}]
	>=dev-python/python-magic-0.4.8[${PYTHON_USEDEP}]
	dev-python/pefile[${PYTHON_USEDEP}]
	dev-python/capstone-python[${PYTHON_USEDEP}]
	dev-python/hyperframe[${PYTHON_USEDEP}]
	dev-python/hyper-h2[${PYTHON_USEDEP}]
	=net-proxy/mitmproxy-0.11*[${PYTHON_USEDEP}]

	plugins? ( net-dns/dnsmasq
		net-analyzer/driftnet
		net-analyzer/ettercap
	)"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	#fix check_depen.py file which is full of typos and mistakes
	epatch "${FILESDIR}"/${PV}_checkdeps.patch
	sed -i 's|/usr/share/wifi-pumpkin|/usr/'$(get_libdir)'/wifi-pumpkin|g' core/loaders/checker/check_depen.py
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	doins -r *

	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
	dosym /usr/$(get_libdir)/${PN}/${PN}.py /usr/sbin/${PN}

	python_optimize "${D}"usr/$(get_libdir)/${PN}
}
