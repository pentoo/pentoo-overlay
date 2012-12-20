# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 git-2

DESCRIPTION="Software defined radio receiver powered by GNU Radio and Qt"
HOMEPAGE="http://www.oz9aec.net/index.php/gnu-radio/gqrx-sdr"
EGIT_REPO_URI="https://github.com/csete/gqrx.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="uhd rtl fcd"

DEPEND="net-wireless/gnuradio[fcd?]
	rtl? ( net-wireless/rtl-sdr )
	uhd? ( net-wireless/uhd )
	net-wireless/gr-osmosdr
	media-sound/pulseaudio"
RDEPEND="${DEPEND}"

src_install() {
	dobin gqrx
}
