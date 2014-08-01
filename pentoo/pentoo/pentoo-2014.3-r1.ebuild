# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="+analyzer +bluetooth +cracking +database +desktop +exploit +footprint +forensics \
	+forging +fuzzers +misc +mitm +mobile pentoo +proxies +radio +rce \
	+scanner +voip +wireless"

S="${WORKDIR}"

DEPEND="!pentoo/pentoo-etc-portage
	pentoo? ( !<pentoo/pentoo-system-2014.3-r1 )"

RDEPEND="pentoo? ( !<pentoo/pentoo-system-2014.3-r1 )"

PDEPEND="
	analyzer? ( pentoo/pentoo-analyzer )
	bluetooth? ( pentoo/pentoo-bluetooth )
	cracking? ( pentoo/pentoo-cracking )
	database? ( pentoo/pentoo-database )
	desktop? ( pentoo/pentoo-desktop )
	exploit? ( pentoo/pentoo-exploit )
	footprint? ( pentoo/pentoo-footprint )
	forensics? ( pentoo/pentoo-forensics )
	forging? ( pentoo/pentoo-forging )
	fuzzers? ( pentoo/pentoo-fuzzers )
	misc? ( pentoo/pentoo-misc )
	mitm? ( pentoo/pentoo-mitm )
	mobile? ( pentoo/pentoo-mobile )
	pentoo? ( pentoo/pentoo-system )
	proxies? ( pentoo/pentoo-proxies )
	radio? ( pentoo/pentoo-radio )
	rce? ( pentoo/pentoo-rce )
	scanner? ( pentoo/pentoo-scanner )
	voip? ( pentoo/pentoo-voip )
	wireless? ( pentoo/pentoo-wireless )"
