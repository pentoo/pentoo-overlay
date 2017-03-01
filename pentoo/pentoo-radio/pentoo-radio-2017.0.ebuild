# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Radio tools for pentoo"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="livecd-stage1 minipentoo"

PDEPEND="net-wireless/gnuradio
	net-wireless/gqrx
	net-wireless/gr-osmosdr
	net-wireless/hackrf-tools
	net-wireless/rtl-sdr
	net-wireless/bladerf

	!minipentoo? (
		net-dialup/minimodem
		net-wireless/portapack-firmware
		net-wireless/inspectrum
		net-wireless/uhd
		net-wireless/chirp
		media-radio/fldigi
		net-wireless/dump1090
		net-wireless/gr-air-modes
		net-analyzer/multimon-ng
		app-mobilephone/dfu-util
		net-wireless/yatebts
		media-radio/qsstv
		media-sound/audacity
		net-wireless/urh
	)"

