# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="radio tools for pentoo"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="mono"

# virtualradar is conditionalized because it requires mono and mono fails to build on all but amd64
# amd64 profile has "pentoo-radio mono" flag
PDEPEND="net-wireless/gnuradio
	net-wireless/rtl-sdr
	net-wireless/gr-osmosdr
	net-wireless/chirp
	media-radio/fldigi
	net-wireless/gr-air-modes
	net-wireless/dump1090
	mono? ( net-wireless/virtualradar-bin )
	net-wireless/uhd
	net-wireless/gqrx
	net-wireless/hackrf-tools
	app-mobilephone/dfu-util
	net-analyzer/multimon-ng
	net-wireless/yatebts
	media-sound/audacity
	media-radio/qsstv"
