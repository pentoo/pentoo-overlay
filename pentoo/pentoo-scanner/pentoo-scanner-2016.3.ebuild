# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="Pentoo scanner meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="minipentoo"

DEPEND=""
RDEPEND="${RDEPEND}
	net-analyzer/nmap

	!minipentoo? (
		amd64? ( net-analyzer/zmap )
		dev-util/skipfish
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
		net-analyzer/webshag
		net-analyzer/wolpertinger
		net-analyzer/wpscan
	)"
