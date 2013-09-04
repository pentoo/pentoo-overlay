# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="Pentoo analyzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="ipv6 gnome ldap"

DEPEND=""

RDEPEND="${DEPEND}
	x86? ( net-analyzer/angst
		net-analyzer/ftester )
	ipv6? ( net-analyzer/thc-ipv6 )
	ldap? ( net-nds/jxplorer )
	net-analyzer/netcat6
	net-analyzer/aimsniff
	net-analyzer/arpwatch
	net-analyzer/chaosreader
	net-analyzer/dnsa
	net-analyzer/dnsenum
	net-analyzer/dnstracer
	net-analyzer/etherape
	net-analyzer/gnome-nettool
	net-analyzer/mbrowse
	net-analyzer/ntop
	net-analyzer/scapy
	net-analyzer/sniffit
	net-analyzer/snmpenum
	net-analyzer/ssltest
	net-analyzer/tcptraceroute
	net-analyzer/thcrut
	net-misc/socat
	net-analyzer/netdiscover
	net-analyzer/ngrep
	net-analyzer/snort
	net-analyzer/tcpdump
	net-analyzer/tcpreplay
	net-analyzer/traceroute
	net-analyzer/cloudshark
	net-analyzer/wireshark
	!arm? ( net-analyzer/xplico )"

#	net-nds/lat depends on mono
#	net-analyzer/driftnet
