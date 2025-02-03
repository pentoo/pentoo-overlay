# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="https://www.pentoo.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+drivers gps livecd-stage1 pentoo-extra pentoo-full +wpe radius"

#util-linux has rfkill now
PDEPEND="
	|| ( net-wireless/hostapd[wpe] net-wireless/hostapd[karma_cli] )
	net-wireless/aircrack-ng
	net-wireless/kismet
	>=sys-apps/util-linux-2.31_rc1
	|| ( net-wireless/mdk4 net-wireless/mdk )
	!livecd-stage1? ( net-wireless/wifite
		drivers? ( !arm? ( net-wireless/rtl8812au_aircrack-ng ) )
		)

	gps? ( sci-geosciences/gpsd )
	|| ( net-wireless/reaver-wps-fork-t6x net-wireless/reaver )

	pentoo-extra? (
		net-wireless/kismetmobiledashboard
	)
	pentoo-full? (
		app-crypt/asleap
		net-wireless/bully
		net-wireless/cowpatty
		net-wireless/hcxtools
		net-wireless/hcxdumptool
		net-wireless/hcxtools
		net-wireless/nrf52840-mdk-usb-dongle
		radius? ( net-dialup/freeradius[wpe] )
		)
"
