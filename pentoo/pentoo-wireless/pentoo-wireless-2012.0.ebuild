# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo wireless meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="+b43 livecd livecd-stage1"

DEPEND=""

RDEPEND="${DEPEND}
	app-crypt/asleap
	!livecd-stage1? ( app-crypt/pyrit
			|| ( net-wireless/compat-wireless
			net-wireless/compat-wireless-builder ) )
	net-dialup/freeradius[wpe]
	b43? ( net-wireless/b43-openfwwf
		net-wireless/broadcom-firmware-downloader )
	net-wireless/aircrack-ng
	net-wireless/airsnort
	net-wireless/wifite
	net-wireless/karmetasploit
	net-wireless/kismet
	net-wireless/mdk
	net-wireless/reaver-wps
	net-wireless/rfkill
	net-wireless/spectools
	net-wireless/orinoco-fwutils
	net-wireless/wepattack
	net-wireless/wepdecrypt
	net-wireless/wifi-radar
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	net-wireless/cowpatty
	net-wireless/crda
	net-wireless/iw
	net-wireless/hostapd[karma]
	net-misc/karma
	sci-geosciences/gpsd"
	#net-wireless/haraldscan
	#net-wireless/wifiscanner
	#x86? ( net-wireless/intel-wimax-network-service )
	#net-wireless/gerix
	#net-wireless/wifitap
	#net-wireless/airpwn
	#net-wireless/airoscript
