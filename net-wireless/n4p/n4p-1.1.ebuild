# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit multilib

DESCRIPTION="Configures network automatically to perform MITM, ARP, SSLstrip, WPA Cracking, and rogue AP attacks"
HOMEPAGE="https://github.com/Cyb3r-Assassin"
SRC_URI="https://github.com/Cyb3r-Assassin/n4p/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wireless +mitm -vpn -extras"

PDEPEND="net-misc/bridge-utils
	>=net-firewall/iptables-1.4.20
	net-misc/dhcpcd
	app-admin/sudo
	sys-apps/iproute2
	x11-terms/xterm
	dev-python/ipaddr
	net-wireless/iw
	sys-apps/openrc
	app-editors/nano
	extras? ( net-analyzer/dhcpdump
		sys-apps/net-tools )
	wireless? ( >=net-wireless/aircrack-ng-1.2_beta3-r3
		net-wireless/rfkill
		>=net-wireless/hostapd-2.0-r1 )
	mitm? ( net-analyzer/sslstrip
		net-analyzer/dsniff
		>=net-analyzer/ettercap-0.8.0-r1 )
	vpn? ( net-misc/openvpn )"

src_install() {
	dodoc changes README.md

	exeinto /usr/$(get_libdir)/${PN}
	doexe n4p.sh n4p_iptables.sh recon.sh monitor.sh n4p_main.sh

	dosym /usr/$(get_libdir)/${PN}/n4p.sh /usr/bin/n4p

	insinto /usr/share/${PN}
	doins auth.logo die.logo dump.logo firewall.logo monitor.logo opening.logo recon.logo zed.logo wash.logo

	insinto /etc/${PN}
	doins n4p.conf dhcpd.conf
}
