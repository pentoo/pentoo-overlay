# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="GPS Spoofing tool for transmit capable SDR's like the HackRF, bladeRF and USRP"
HOMEPAGE="http://sdr.osmocom.org/trac/wiki/rtl-sdr"
SRC_URI=""
EGIT_REPO_URI="https://github.com/osqzss/gps-sdr-sim.git"

KEYWORDS=""
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
	dobin gps-sdr-sim-uhd.py
	dobin gps-sdr-sim

	insinto /usr/share/${PN}
	doins {brdc3540.14n,*.csv,triumphv3.txt}

	dodoc README.md
}
