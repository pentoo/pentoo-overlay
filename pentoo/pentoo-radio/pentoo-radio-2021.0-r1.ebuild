# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Radio tools for pentoo"
HOMEPAGE="pentoo.ch"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+bladerf bluetooth +hackrf +limesdr pentoo-full +plutosdr pulseaudio"

PDEPEND="net-wireless/gnuradio
	net-wireless/gqrx
	net-wireless/gr-osmosdr
	net-wireless/rtl-sdr
	hackrf? ( net-wireless/hackrf-tools )
	bladerf? ( net-wireless/bladerf )
	limesdr? ( net-wireless/limesuite )
	plutosdr? ( net-wireless/gr-iio )

	bluetooth? ( net-wireless/btle-sniffer )
	pentoo-full? (
		app-misc/rtlamr
		app-mobilephone/dfu-util
		media-radio/fldigi
		pulseaudio? ( media-radio/qsstv )
		media-radio/wsjtx
		media-sound/audacity
		net-analyzer/multimon-ng
		net-dialup/minimodem
		amd64? ( net-wireless/editcp-bin )
		net-wireless/dump1090
		net-wireless/gr-ieee802154
		net-wireless/gr-rds
		net-wireless/gr-scan
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
		net-wireless/uhd
		net-wireless/urh
		net-wireless/yatebts
		media-radio/gpredict
		amd64? ( net-wireless/mjackit )
		net-wireless/jackit
	)"

#no python3 yet
#		net-wireless/chirp
#		net-wireless/mousejack
