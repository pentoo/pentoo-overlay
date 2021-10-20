# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A visualization we use for the RF Village"
HOMEPAGE="http://rfhackers.com"
SRC_URI="https://dev.pentoo.ch/~zero/distfiles/${P}.tar.xz"

#powermate.py is Apache 2, the rest is BSD
LICENSE="BSD Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="=net-wireless/gnuradio-3.8*:=
	net-wireless/gr-paint"
RDEPEND="${DEPEND}"
BDEPEND=""
PDEPEND="net-wireless/uhd:=
	net-analyzer/gr-fosphor
	x11-misc/wmctrl"

#powermate.py from https://github.com/bethebunny/powermate

src_compile() {
	grcc -o "${S}" fosphor_with_griffin_powermate_knob.grc || die
	grcc -o "${S}" fosphor_with_griffin_powermate_knob_sponsors.grc || die
	grcc -o "${S}" fosphor_with_griffin_powermate_knob_hackrf_sweep.grc || die
	grcc -o "${S}" fosphor_with_griffin_powermate_knob_hackrf_sweep_sponsors.grc || die
}

src_install() {
	insinto /usr/share/${PN}
	doins *.py *.grc
	doins scrolly.png
	fperms +x /usr/share/${PN}/run.py
	fperms +x /usr/share/${PN}/fosphor_knob.py
	fperms +x /usr/share/${PN}/fosphor_knob_sponsors.py
	fperms +x /usr/share/${PN}/fosphor_knob_hackrf_sweep.py
	fperms +x /usr/share/${PN}/fosphor_knob_hackrf_sweep_sponsors.py
	newbin fosphor_knob.sh fosphor_knob
	dosym fosphor_knob /usr/bin/fosphor_knob_sponsors
	dosym fosphor_knob /usr/bin/fosphor_knob_hackrf_sweep
	dosym fosphor_knob /usr/bin/fosphor_knob_hackrf_sweep_sponsors
}
