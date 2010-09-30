# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo voip meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

#the tools
RDEPEND="${RDEPEND}
	net-analyzer/sipvicious
	net-analyzer/videojak
	net-analyzer/voiphopper
	net-misc/minisip
	x86? ( net-misc/partysip )
	net-misc/sipbomber
	net-misc/sipp
	net-misc/siproxd
	net-misc/sipsak
	net-analyzer/videojak
	net-misc/voipong"
