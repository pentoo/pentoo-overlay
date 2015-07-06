# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Radio tools for pentoo"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="minipentoo mono"

# virtualradar is conditionalized because it requires mono and mono fails to build on all but amd64
# amd64 profile has "pentoo-radio mono" flag
PDEPEND="net-wireless/gnuradio
	net-wireless/gqrx
	net-wireless/gr-osmosdr

	!minipentoo? (
		net-wireless/hackrf-tools
		net-wireless/rtl-sdr
		net-wireless/uhd
		net-wireless/bladerf
		net-wireless/chirp
		media-radio/fldigi
		net-wireless/dump1090
		net-wireless/gr-air-modes
		app-mobilephone/dfu-util
		net-analyzer/multimon-ng
		net-wireless/yatebts
		media-radio/qsstv
		media-sound/audacity
	)

	mono? ( net-wireless/virtualradar-bin )"
