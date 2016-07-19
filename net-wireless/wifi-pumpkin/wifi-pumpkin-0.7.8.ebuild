# Copyright 1999-2016 Gentoo Foundation
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
IUSE="+wpe"

DEPEND=""
RDEPEND="net-wireless/hostapd[wpe?]
	net-wireless/rfkill
	dev-python/PyQt4
	dev-python/twisted-web
	net-analyzer/scapy
	dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	dev-python/python-nmap
	dev-python/netaddr
	dev-python/config
	virtual/python-dnspython
	dev-python/isc_dhcp_leases
	dev-python/netifaces
	dev-python/pcapy
	dev-python/configparser
	dev-python/pygtail"

#python-scapy
#PIL if you want upsidedownternet to work
#arpspoof or ettercap if you want to use ArpSpoof plugin

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	#fix check_depen file which is full of typos and mistakes
	epatch "${FILESDIR}"/wifi-pumpkin_checkdeps.patch
	sed -i 's|/usr/share/wifi-pumpkin|/usr/'$(get_libdir)'/wifi-pumpkin|g' Core/loaders/checker/check_depen.py

	if use wpe; then
		sed -i 's|which hostapd|which hostapd-wpe|g' Core/loaders/checker/check_depen.py || die
	fi

	tar -xf Settings/source.tar.gz -C Templates/
	rm Settings/source.tar.gz

}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	doins -r *

	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
	dosym /usr/$(get_libdir)/${PN}/${PN}.py /usr/sbin/${PN}

	python_optimize "${D}"usr/$(get_libdir)/${PN}
}
