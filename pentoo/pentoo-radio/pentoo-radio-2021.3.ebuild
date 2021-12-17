# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Radio tools for pentoo"
HOMEPAGE="pentoo.ch"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+bladerf bluetooth +hackrf +limesdr pentoo-full +plutosdr pulseaudio +rtlsdr +uhd"

PDEPEND="net-wireless/gnuradio[uhd?]
	net-wireless/gqrx
	net-wireless/gr-osmosdr
	hackrf? ( net-wireless/hackrf-tools )
	bladerf? ( net-wireless/bladerf )
	limesdr? ( net-wireless/limesuite )
	plutosdr? ( net-wireless/gr-iio )
	rtlsdr? ( net-wireless/rtl-sdr )

	bluetooth? (
				bladerf? ( net-wireless/btle-sniffer )
				hackrf? ( net-wireless/btle-sniffer )
				)
	pentoo-full? (
		amd64? (
			net-wireless/editcp-bin
			net-wireless/mjackit
			net-wireless/srslte
			)
		app-misc/rtlamr
		app-mobilephone/dfu-util
		media-radio/fldigi
		pulseaudio? ( media-radio/qsstv )
		media-radio/wsjtx
		media-sound/audacity
		net-analyzer/multimon-ng
		net-dialup/minimodem
		net-wireless/qdmr
		net-wireless/dump1090
		net-wireless/gr-ieee802154
		net-wireless/gr-rds
		net-wireless/inspectrum
		net-wireless/killerbee
		net-wireless/rfcat
		net-wireless/rtl_433
		net-wireless/rtl_power_fftw
		net-wireless/sigdigger
		net-wireless/tempestsdr
		net-wireless/osmo-fl2k
		hackrf? (
			net-wireless/portapack-firmware
			net-wireless/portapack-mayhem
			)
		net-wireless/qspectrumanalyzer
		net-wireless/rx_tools
		uhd? ( net-wireless/uhd )
		net-wireless/urh
		net-wireless/yatebts
		media-radio/gpredict
		net-wireless/jackit
	)"

#no python3 yet
#		net-wireless/chirp
#		net-wireless/mousejack
