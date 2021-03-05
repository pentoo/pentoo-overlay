# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo voip meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="pentoo-full"

#add viproy to the main section
PDEPEND="
	net-voip/sipvicious
	net-misc/sipp

	pentoo-full? (
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
