# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

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

	!minipentoo? (
		net-analyzer/amap
		net-analyzer/blindelephant
		net-analyzer/geoedge
		net-analyzer/metagoofil
		net-analyzer/ntp-fingerprint
		net-analyzer/p0f
		net-analyzer/scanssh
		net-analyzer/siphon
		net-analyzer/smtpmap
		net-analyzer/subdomainer
		net-analyzer/theHarvester
		net-analyzer/wfuzz
		net-analyzer/xprobe
	)"

#   dep on dnspython causes dep failure
#	net-analyzer/fierce
