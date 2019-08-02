# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Radio tools for pentoo"
HOMEPAGE="pentoo.ch"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+bladerf +hackrf pentoo-full +plutosdr"

PDEPEND="net-wireless/gnuradio
	net-wireless/gqrx
	net-wireless/gr-osmosdr
	net-wireless/rfcat
	net-wireless/rtl-sdr
	hackrf? ( net-wireless/hackrf-tools )
	bladerf? ( net-wireless/bladerf )
	plutosdr? ( net-wireless/gr-iio )

	pentoo-full? (
		app-misc/rtlamr
		app-mobilephone/dfu-util
		media-radio/fldigi
		media-radio/qsstv
		media-radio/wsjtx
		media-sound/audacity
		net-analyzer/multimon-ng
		net-dialup/minimodem
		net-wireless/chirp
		amd64? ( net-wireless/editcp-bin )
		net-wireless/dump1090
		net-wireless/gr-ieee802154
		net-wireless/inspectrum
		net-wireless/killerbee
		net-wireless/rtl_433
		net-wireless/rtl_power_fftw
		net-wireless/osmo-fl2k
		hackrf? (
			net-wireless/portapack-firmware
			net-wireless/portapack-havoc
			)
		net-wireless/qspectrumanalyzer
		net-wireless/rx_tools
		net-wireless/uhd
		net-wireless/urh
		net-wireless/yatebts
		net-wireless/mousejack
		net-wireless/mjackit
		net-wireless/jackit
	)"
