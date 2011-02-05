# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo voip meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""

#the tools
RDEPEND="${RDEPEND}
	net-analyzer/sipvicious
	net-analyzer/videojak
	net-analyzer/vomit
	net-analyzer/voiphopper
	net-misc/sipp
	net-misc/siproxd
	net-misc/sipsak
	net-misc/voipong
	net-misc/warvox"
	#net-misc/minisip
	#net-misc/sipbomber
	#x86? ( net-misc/partysip )
	#net-analyzer/ucsniff
