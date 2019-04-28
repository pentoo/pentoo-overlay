# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A visualization we use for the Wireless Village"
HOMEPAGE="http://wctf.ninja"
SRC_URI="https://dev.pentoo.ch/~zero/distfiles/${P}.tar.xz"

#powermate.py is Apache 2, the rest is BSD
LICENSE="BSD Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="net-wireless/gnuradio
	net-wireless/gr-paint"
RDEPEND="${DEPEND}"
BDEPEND=""
PDEPEND="net-wireless/uhd
	net-analyzer/gr-fosphor
	x11-misc/wmctrl"

#powermate.py from https://github.com/bethebunny/powermate

src_compile() {
	grcc -d "${S}" fosphor_with_griffin_powermate_knob.grc
	grcc -d "${S}" fosphor_with_griffin_powermate_knob_sponsors.grc
}

src_install() {
	insinto /usr/share/${PN}
	doins *.py *.grc
	doins scrolly.png
	fperms +x /usr/share/${PN}/run.py
	fperms +x /usr/share/${PN}/fosphor_knob.py
	fperms +x /usr/share/${PN}/fosphor_knob_sponsors.py
	newbin fosphor_knob.sh fosphor_knob
	dosym fosphor_knob /usr/bin/fosphor_knob_sponsors
}
