# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo scanner meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

#the tools
RDEPEND="${RDEPEND}
	net-analyzer/enum4linux
	net-analyzer/firewalk
	net-analyzer/hunt
	net-analyzer/ike-scan
	net-analyzer/nbtscan
	net-analyzer/nessus
	net-analyzer/nikto
	net-analyzer/nmap
	net-analyzer/nmbscan
	net-analyzer/onesixtyone
	net-analyzer/ppscan
	net-analyzer/sara
	net-analyzer/scanssh
	net-analyzer/upnpscan
	net-analyzer/wapiti
	net-analyzer/webshag
	net-analyzer/wolpertinger"
	#net-analyzer/autoscan-network

