# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="Pentoo analyzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="ipv6 java gnome minipentoo ldap"

DEPEND=""
RDEPEND="${DEPEND}
	net-analyzer/dnsrecon
	net-analyzer/netcat6
	net-analyzer/net-snmp
	net-analyzer/scapy
	net-analyzer/sslyze
	net-analyzer/tcpdump
	net-analyzer/tcptraceroute
	net-analyzer/traceroute
	net-analyzer/wireshark

	!minipentoo? (
		ipv6? ( net-analyzer/thc-ipv6
			|| ( net-analyzer/ipv6toolkit net-analyzer/ipv6-toolkit ) )
		java? ( ldap? ( net-nds/jxplorer ) )
		x86? ( net-analyzer/angst )
		net-analyzer/aimsniff
		net-analyzer/arpwatch
		net-analyzer/chaosreader
		net-analyzer/cloudshark
		net-analyzer/dnsa
		net-analyzer/dnsenum
		net-analyzer/dnstracer
		net-analyzer/etherape
		net-analyzer/ftester
		net-analyzer/gnome-nettool
		net-analyzer/mbrowse
		net-analyzer/mtr
		net-analyzer/netdiscover
		net-analyzer/ngrep
		net-analyzer/ntop
		net-analyzer/sniffit
		net-analyzer/snort
		net-analyzer/snmpenum
		net-analyzer/tcpreplay
		net-analyzer/thcrut
		net-misc/socat
	)"

#	net-nds/lat depends on mono
#	net-analyzer/driftnet
