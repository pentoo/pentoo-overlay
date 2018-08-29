# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo analyzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="ipv6 java gnome ldap pentoo-full"

PDEPEND="
	net-analyzer/netcat6
	net-analyzer/net-snmp
	net-analyzer/scapy
	net-analyzer/tcpdump
	net-analyzer/tcptraceroute
	net-analyzer/testssl
	net-analyzer/traceroute
	net-analyzer/wireshark
	net-misc/whatmask

	pentoo-full? (
		ipv6? ( net-analyzer/thc-ipv6
			net-analyzer/ipv6toolkit )
		java? ( ldap? ( net-nds/jxplorer ) )
               x86? arm? arm64? ( net-analyzer/angst )  #dose build for arm64
		net-analyzer/arpwatch
		net-analyzer/chaosreader
		net-analyzer/cloudshark
		net-analyzer/dnsa
		net-analyzer/dnstracer
		net-analyzer/etherape
		net-analyzer/ftester
		net-analyzer/gnome-nettool
		net-analyzer/mbrowse
		net-analyzer/mtr
		net-analyzer/netdiscover
		net-analyzer/ngrep
		net-analyzer/ntopng
		net-analyzer/sniffit
		net-analyzer/snmpenum
		net-analyzer/snort
		net-analyzer/sslscan
		net-analyzer/sslyze
		net-analyzer/tcpreplay
		net-analyzer/thcrut
		net-misc/socat
	)"

#	net-nds/lat depends on mono
#	net-analyzer/driftnet
