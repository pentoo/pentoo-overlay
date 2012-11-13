# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="radio tools for pentoo"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-wireless/gnuradio
	net-wireless/rtl-sdr
	net-wireless/op25
	net-wireless/gr-osmosdr
	net-wireless/chirp
	media-radio/fldigi
	net-wireless/gr-air-modes
	amd64? ( net-wireless/virtualradar-bin )
	net-wireless/uhd
	net-wireless/multimode
	media-sound/baudline
"
#virtualradar is conditionalized because it requires mono and mono fails to build on x86

# failing to build on git rev at 20121110
#	net-wireless/gr-baz
