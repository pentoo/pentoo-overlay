# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
DESCRIPTION="Pentoo voip meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="minipentoo"

DEPEND=""

#add viproy to the main section
RDEPEND="${DEPEND}
	net-analyzer/sipvicious
	net-misc/sipp

	!minipentoo? (
		net-analyzer/voiphopper
		net-misc/sipsak
		net-misc/voipong
	)"

#	outdated tools
	#net-analyzer/vomit
	#net-analyzer/videojak
	#net-analyzer/ucsniff
	#net-misc/siproxd
	#net-misc/minisip
	#net-misc/sipbomber
	#x86? ( net-misc/partysip )
	#net-analyzer/ucsniff
	#net-misc/warvox
