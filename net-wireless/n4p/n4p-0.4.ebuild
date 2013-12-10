# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="Configures network variables automatically for MITM, ARP, and SSLstriping attacks"
HOMEPAGE="https://github.com/Cyb3r-Assassin"
SRC_URI="https://github.com/Cyb3r-Assassin/n4p/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wireless +mitm +vpn"

DEPEND=""

RDEPEND="net-misc/bridge-utils
	>=net-firewall/iptables-1.4.20
	net-firewall/ebtables
	net-misc/dhcpcd
	net-dns/dnsmasq
	wireless? ( net-wireless/hostapd
		>=net-wireless/aircrack-ng-1.2_beta1
		net-wireless/wpa_supplicant )
	mitm? ( net-analyzer/sslstrip
		net-analyzer/dsniff )
	dev-python/ipaddr
	net-wireless/iw
	vpn? ( net-misc/openvpn )
	sys-apps/openrc"

src_install() {
	dodoc changes README.md
	rm changes LICENSE README.md

	insinto /usr/$(get_libdir)
	doins -r "${S}"

	fperms +x /usr/lib64/${P}/n4p.sh
	dosym /usr/$(get_libdir)/${P}/n4p.sh /usr/bin/n4p
}
