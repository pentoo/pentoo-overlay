# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="+b43 cuda gps drivers livecd-stage1 minipentoo opencl +wpe ${IUSE_VIDEO_CARDS}"

PDEPEND="
	|| ( net-wireless/hostapd[karma] net-wireless/hostapd[karma_cli] )
	net-wireless/aircrack-ng
	net-dialup/freeradius[wpe?]
	net-wireless/kismet
	net-wireless/rfkill
	net-wireless/crda
	net-wireless/mdk
	!livecd-stage1? ( net-wireless/wifite )
	!app-crypt/pyrit

	!minipentoo? (
		!livecd-stage1? (
			video_cards_nvidia? (
				opencl? ( net-wireless/pyrit[opencl] )
				cuda? ( net-wireless/pyrit[cuda] )
			)
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
