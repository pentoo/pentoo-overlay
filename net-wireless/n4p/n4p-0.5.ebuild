# Copyright 1999-2014 Gentoo Foundation
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
	net-misc/dhcpcd
	sys-apps/iproute2
	wireless? ( >=net-wireless/aircrack-ng-1.2_beta1
		net-wireless/rfkill )
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

	fperms +x /usr/$(get_libdir)/${P}/n4p.sh
	fperms +x /usr/$(get_libdir)/${P}/n4p_iptables.sh
	dosym /usr/$(get_libdir)/${P}/n4p.sh /usr/bin/n4p
	dosym /usr/$(get_libdir)/${P}/n4p_iptables.sh /usr/bin/n4p_iptables
}
