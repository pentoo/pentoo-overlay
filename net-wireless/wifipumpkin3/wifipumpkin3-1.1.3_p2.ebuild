# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_p/-R}"
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Framework for Rogue Wi-Fi Access Point Attack"
HOMEPAGE="https://github.com/P0cL4bs/wifipumpkin3"
SRC_URI="https://github.com/P0cL4bs/wifipumpkin3/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"

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
	dev-python/dnslib[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/isc_dhcp_leases[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/flask-restx[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]

	tools? ( net-firewall/iptables
		sys-apps/net-tools
		net-wireless/iw
		net-analyzer/responder
		net-wireless/wireless-tools
		net-wireless/hostapd[wpe]
	)"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	#https://github.com/P0cL4bs/wifipumpkin3/pull/191
	eapply "${FILESDIR}"/191.patch
	eapply "${FILESDIR}"/192.patch

	#FIXME: give up, fix all deps
	echo "netifaces" > requirements.txt
	#relax deps
#	sed -e 's|==.*||' -i requirements.txt || die "sed failed"
#	sed -e 's|scapy.*$|scapy|' -i requirements.txt || die "sed failed"

	#https://github.com/P0cL4bs/wifipumpkin3/issues/189
	sed -e 's|wifipumpkin3/data/|share/wifipumpkin3/data/|' -i setup.py || die "sed failed"

	eapply_user
}
