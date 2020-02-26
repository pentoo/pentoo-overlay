# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo analyzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="ipv6 java gnome ldap pentoo-extra pentoo-full"

PDEPEND="
	|| ( net-analyzer/openbsd-netcat net-analyzer/netcat )
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
		x86? ( net-analyzer/angst )
		net-analyzer/net-snmp
		net-analyzer/chaosreader
		net-analyzer/cloudshark
		net-analyzer/dnstracer
		net-analyzer/ftester
		net-analyzer/gnome-nettool
		net-analyzer/mbrowse
		net-analyzer/mtr
		net-analyzer/netdiscover
		net-analyzer/ngrep
		net-analyzer/snmpenum
		net-analyzer/snort
		net-analyzer/sslscan
		net-analyzer/sslyze
		net-analyzer/tcpreplay
		net-analyzer/termshark
		net-analyzer/thcrut
		net-misc/socat
	)
	pentoo-extra? (
		net-analyzer/arpwatch
		net-analyzer/etherape
	)"

#	net-nds/lat depends on mono
#	net-analyzer/driftnet
