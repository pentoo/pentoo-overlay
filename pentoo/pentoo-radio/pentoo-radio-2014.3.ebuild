# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="radio tools for pentoo"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

PDEPEND="net-wireless/gnuradio
	net-wireless/rtl-sdr
	net-wireless/gr-osmosdr
	net-wireless/chirp
	media-radio/fldigi
	net-wireless/gr-air-modes
	amd64? ( net-wireless/virtualradar-bin )
	net-wireless/uhd
	net-wireless/multimode
	net-wireless/gqrx
	net-wireless/hackrf-tools
	net-analyzer/multimon-ng
	net-wireless/yatebts
"
#virtualradar is conditionalized because it requires mono and mono fails to build on x86
