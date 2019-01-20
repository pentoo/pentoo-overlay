# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A visualization we use for the Wireless Village"
HOMEPAGE="http://wctf.ninja"
SRC_URI="https://dev.pentoo.ch/~zero/distfiles/${P}.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
PDEPEND="net-wireless/gnuradio
	net-wireless/uhd"

src_install() {
	insinto /usr/share/${PN}
	doins *.py *.grc
	fperms +x /usr/share/${PN}/run.py
	newbin fosphor_knob.sh fosphor_knob
}
