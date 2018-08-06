# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Radio tools for pentoo"
HOMEPAGE="pentoo.ch"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+bladerf +hackrf pentoo-full"

PDEPEND="net-wireless/gnuradio
	net-wireless/gqrx
	net-wireless/gr-osmosdr
	net-wireless/rtl-sdr
	net-wireless/rtl_433
	hackrf? ( net-wireless/hackrf-tools )
	bladerf? ( net-wireless/bladerf )

	pentoo-full? (
		app-mobilephone/dfu-util
		media-radio/fldigi
		media-radio/qsstv
		media-sound/audacity
		net-analyzer/multimon-ng
		net-dialup/minimodem
		net-wireless/chirp
		net-wireless/dump1090
		net-wireless/gr-ieee802154
		net-wireless/inspectrum
		net-wireless/killerbee
		net-wireless/osmo-fl2k
		net-wireless/portapack-firmware
		amd64? ( net-wireless/proxmark3 )
		net-wireless/qspectrumanalyzer
		net-wireless/rx_tools
		net-wireless/uhd
		net-wireless/urh
		net-wireless/yatebts
	)"
