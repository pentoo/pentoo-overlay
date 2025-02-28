# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo scanner meta ebuild"
HOMEPAGE="https://www.pentoo.org"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"

IUSE="pentoo-full"

PDEPEND="net-analyzer/nmap
	net-analyzer/mdns-scan
	pentoo-full? (
		net-analyzer/enum4linux
		net-analyzer/firewalk
		net-analyzer/hunt
		net-analyzer/ike-scan
		net-analyzer/nbtscan
		net-analyzer/nikto
		net-analyzer/nmbscan
		net-analyzer/onesixtyone
		net-analyzer/ppscan
		net-analyzer/scanssh
		net-analyzer/upnpscan
		amd64? ( net-analyzer/wpscan
			net-analyzer/zmap )
	)"
#removed from pentoo-full because it causes bootstrap issues due to unstable python deps
#net-analyzer/wapiti
