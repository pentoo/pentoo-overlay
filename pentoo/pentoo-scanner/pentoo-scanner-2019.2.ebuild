# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo scanner meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 arm x86"

SLOT="0"
LICENSE="GPL-3"
IUSE="pentoo-full"

PDEPEND="net-analyzer/nmap
	net-analyzer/mdns-scan
	pentoo-full? (
		amd64? ( net-analyzer/zmap )
		net-analyzer/enum4linux
		net-analyzer/firewalk
		net-analyzer/hunt
		net-analyzer/ike-scan
		net-analyzer/nbtscan
		net-analyzer/nikto
		net-analyzer/nmap_vulscan
		net-analyzer/nmbscan
		net-analyzer/onesixtyone
		net-analyzer/ppscan
		net-analyzer/scanssh
		net-analyzer/upnpscan
		net-analyzer/wapiti
		net-analyzer/wpscan
	)"
