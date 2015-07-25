# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+b43 cuda gps drivers livecd-stage1 minipentoo +wpe"

PDEPEND="
	|| ( net-wireless/hostapd[karma] net-wireless/hostapd[karma_cli] )
	net-wireless/aircrack-ng
	net-dialup/freeradius[wpe?]
	net-wireless/kismet
	net-wireless/rfkill
	net-wireless/crda
	net-wireless/mdk
	!livecd-stage1? ( net-wireless/wifite )

	!minipentoo? (
		!livecd-stage1? ( cuda? ( app-crypt/pyrit )
			drivers? (
				|| ( net-wireless/compat-wireless
					net-wireless/compat-wireless-builder
					sys-kernel/compat-drivers )
				b43? ( net-wireless/b43-openfwwf
					net-wireless/broadcom-firmware-downloader )
				net-wireless/orinoco-fwutils
			)
		)
	gps? ( sci-geosciences/gpsd )
	app-crypt/asleap
	net-wireless/airsnort
	net-wireless/bully
	net-wireless/cowpatty
	net-wireless/fern-wifi-cracker
	|| ( net-wireless/reaver-wps-fork-t6x net-wireless/reaver )
	net-wireless/spectools
	net-wireless/wepattack
	net-wireless/n4p
	)
"

pkg_postinst() {
	use !drivers && ewarn "Disabling drivers for pentoo-wireless may make injection impossible and may provide support for fewer wifi cards with more bugs"
}
