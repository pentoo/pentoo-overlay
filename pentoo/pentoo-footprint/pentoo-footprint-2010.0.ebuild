# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo footprint meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	net-analyzer/amap
	net-analyzer/fierce
	net-analyzer/geoedge
	net-analyzer/metagoofil
	net-analyzer/ntp-fingerprint
	net-analyzer/p0f
	net-analyzer/scanssh
	net-analyzer/siphon
	net-analyzer/smtpmap
	net-analyzer/subdomainer
	net-analyzer/theHarvester
	net-analyzer/wafp
	net-analyzer/wfuzz
	net-analyzer/xprobe"

