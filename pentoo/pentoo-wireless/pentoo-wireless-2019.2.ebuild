# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cuda gps +drivers livecd-stage1 pentoo-extra pentoo-full opencl +wpe"

#util-linux has rfkill now
PDEPEND="
	|| ( net-wireless/hostapd[wpe] net-wireless/hostapd[karma_cli] )
	net-wireless/aircrack-ng
	net-dialup/freeradius
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
		net-wireless/airsnort
		net-wireless/n4p
		net-wireless/spectools
		net-wireless/wepattack
	)
	pentoo-full? (
		app-crypt/asleap
		net-wireless/bully
		net-wireless/cowpatty
		net-wireless/kismetdb
		net-wireless/kismetmobiledashboard
		net-wireless/hcxtools
		net-wireless/hcxdumptool
		net-wireless/hcxtools
		)
"
