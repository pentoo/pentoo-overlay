# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV/_p/R}"
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Framework for Rogue Wi-Fi Access Point Attack"
HOMEPAGE="https://github.com/P0cL4bs/wifipumpkin3"
SRC_URI="https://github.com/P0cL4bs/wifipumpkin3/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="tools"

RDEPEND="${PYTHON_DEPS}
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/dhcplib[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/urwid[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/PyQt5-sip[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	net-analyzer/responder
	dev-python/dnslib[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/isc_dhcp_leases[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/jwt[${PYTHON_USEDEP}]
	dev-python/flask-restful[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]

	tools? ( net-firewall/iptables
		net-wireless/iw
		sys-apps/net-tools
		net-wireless/wireless-tools
		net-wireless/hostapd[wpe]
	)"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	#relax deps
	sed -e 's|==.*||' -i requirements.txt || die "sed failed"
	sed -e 's|Responder3.*$|responder|' -i requirements.txt || die "sed failed"
	sed -e 's|scapy.*$|scapy|' -i requirements.txt || die "sed failed"
#	sed -e '/ipaddress/d' -e '/configparser/d' -i requirements.txt || die "sed failed"

	#FIXME: give up, fix all names here:
	echo "netifaces" > requirements.txt

	eapply_user

}
