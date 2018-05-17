# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cuda gps +drivers livecd-stage1 minipentoo opencl +wpe"

PDEPEND="
	|| ( net-wireless/hostapd[wpe] net-wireless/hostapd[karma_cli] )
	net-wireless/aircrack-ng
	net-dialup/freeradius
	net-wireless/kismet
	net-wireless/rfkill
	net-wireless/crda
	net-wireless/mdk
	!livecd-stage1? ( net-wireless/wifite )

	!minipentoo? (
		!livecd-stage1? (
			drivers? (
				net-wireless/rtl8812au_aircrack-ng
			)
		)
	gps? ( sci-geosciences/gpsd )
	app-crypt/asleap
	net-wireless/airsnort
	net-wireless/bully
	net-wireless/cowpatty
	|| ( net-wireless/reaver-wps-fork-t6x net-wireless/reaver )
	net-wireless/spectools
	net-wireless/wepattack
	net-wireless/n4p
	)
"
