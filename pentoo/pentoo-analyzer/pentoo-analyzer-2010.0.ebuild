# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo analyzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	x86? ( net-analyzer/angst
		net-analyzer/ftester )
	net-analyzer/aimsniff
	net-analyzer/arpwatch
	net-analyzer/bmon
	net-analyzer/chaosreader
	net-analyzer/dnsa
	net-analyzer/dnsenum
	net-analyzer/etherape
	net-analyzer/gnome-nettool
	net-analyzer/mbrowse
	net-analyzer/ntop
	net-analyzer/sniffit
	net-analyzer/snmpenum
	net-analyzer/tcptraceroute
	net-analyzer/thcrut
	net-misc/socat
	net-nds/gq
	net-nds/lat"

#	net-analyzer/driftnet
