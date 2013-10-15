# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-2"
IUSE="+b43 cuda gps drivers livecd-stage1 +wpe"

DEPEND=""

RDEPEND="${DEPEND}
	!livecd-stage1? ( cuda? ( app-crypt/pyrit )
			net-wireless/wifite
		drivers? (
			|| (
				net-wireless/compat-wireless
				net-wireless/compat-wireless-builder
				sys-kernel/compat-drivers )
			b43? ( net-wireless/b43-openfwwf
				net-wireless/broadcom-firmware-downloader )
			net-wireless/orinoco-fwutils
		)
	)
	gps? ( sci-geosciences/gpsd )
	app-crypt/asleap
	net-dialup/freeradius[wpe?]
	net-wireless/aircrack-ng
	net-wireless/airsnort
	net-wireless/cowpatty
	net-wireless/crda
	net-wireless/fern-wifi-cracker
	net-wireless/karmetasploit
	net-wireless/kismet
	net-wireless/mdk
	net-wireless/reaver
	net-wireless/rfkill
	net-wireless/spectools
	net-wireless/wepattack
	|| ( net-wireless/hostapd[karma] net-wireless/hostapd[karma_cli] )"
	#net-misc/karma
	#net-wireless/haraldscan
	#net-wireless/wifiscanner
	#x86? ( net-wireless/intel-wimax-network-service )
	#net-wireless/gerix
	#net-wireless/wifitap
	#net-wireless/airpwn
	#net-wireless/airoscript
	#net-wireless/wepdecrypt

pkg_postinst() {
	use !drivers && ewarn "Disabling drivers for pentoo-wireless may make injection impossible and may provide support for fewer wifi cards with more bugs"
}
