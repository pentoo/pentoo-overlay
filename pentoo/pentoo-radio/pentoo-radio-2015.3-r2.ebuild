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
IUSE="livecd-stage1 minipentoo mono"

# virtualradar is conditionalized because it requires mono and mono fails to build on all but amd64
# amd64 profile has "pentoo-radio mono" flag
PDEPEND="net-wireless/gnuradio
	net-wireless/gqrx
	net-wireless/gr-osmosdr
	net-wireless/hackrf-tools
	net-wireless/rtl-sdr
	net-wireless/bladerf

	!minipentoo? (
		net-wireless/portapack-firmware
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
		!livecd-stage1? ( mono? ( net-wireless/virtualradar-bin ) )
	)"

