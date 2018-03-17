# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo footprint meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 ~arm x86"
IUSE="minipentoo"

DEPEND=""
RDEPEND="${DEPEND}
	net-analyzer/whatweb
	net-analyzer/wafw00f
	net-analyzer/sublist3r

	!minipentoo? (
		net-analyzer/amap
		net-analyzer/fierce
	net-analyzer/dnsrecon
		net-analyzer/geoedge
		net-analyzer/metagoofil
		net-analyzer/ntp-fingerprint
		net-analyzer/p0f
		net-analyzer/recon-ng
		net-analyzer/scanssh
		net-analyzer/siphon
		net-analyzer/smtpmap
		net-analyzer/subdomainer
		net-analyzer/theHarvester
		net-analyzer/wfuzz
		net-analyzer/xprobe
	)"
