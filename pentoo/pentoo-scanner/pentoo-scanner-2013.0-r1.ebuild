# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Pentoo scanner meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

#the tools
RDEPEND="${RDEPEND}
	dev-util/skipfish
	net-analyzer/enum4linux
	net-analyzer/firewalk
	net-analyzer/hunt
	net-analyzer/ike-scan
	net-analyzer/nbtscan
	net-analyzer/nikto
	net-analyzer/nmap
	net-analyzer/nmap_vulscan
	net-analyzer/nmbscan
	net-analyzer/onesixtyone
	net-analyzer/ppscan
	net-analyzer/scanssh
	net-analyzer/upnpscan
	net-analyzer/wapiti
	net-analyzer/webshag
	net-analyzer/wolpertinger
	net-analyzer/wpscan
	"
	#net-analyzer/autoscan-network
