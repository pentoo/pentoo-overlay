# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gps +drivers livecd-stage1 pentoo-extra pentoo-full +wpe +radius"

#util-linux has rfkill now
PDEPEND="
	|| ( net-wireless/hostapd[wpe] net-wireless/hostapd[karma_cli] )
	net-wireless/aircrack-ng
	radius? ( net-dialup/freeradius[wpe] )
	net-wireless/kismet
	>=sys-apps/util-linux-2.31_rc1
	net-wireless/crda
	net-wireless/mdk
	!livecd-stage1? ( net-wireless/wifite
		drivers? ( !arm? ( net-wireless/rtl8812au_aircrack-ng ) )
		)

	gps? ( sci-geosciences/gpsd )
	|| ( net-wireless/reaver-wps-fork-t6x net-wireless/reaver )

	pentoo-extra? (
		net-wireless/kismetmobiledashboard
		net-wireless/spectools
		net-wireless/wepattack
	)
	pentoo-full? (
		app-crypt/asleap
		net-wireless/bully
		net-wireless/cowpatty
		net-wireless/linssid
		net-wireless/hcxtools
		net-wireless/hcxdumptool
		net-wireless/hcxtools
		)
"
