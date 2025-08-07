# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A visualization we use for the RF Village"
HOMEPAGE="http://rfhackers.com"

if [[ "${PV}" == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/rfhs/fosphor_knob.git"
	inherit git-r3
	RESTRICT="strip"
else
	SRC_URI="https://github.com/rfhs/fosphor_knob/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

#powermate.py is Apache 2, the rest is GPL-3
LICENSE="GPL-3 Apache-2.0"
SLOT="0"

DEPEND="net-wireless/gnuradio:=
	net-wireless/gr-paint"
RDEPEND="${DEPEND}
	net-wireless/uhd:=
	net-analyzer/gr-fosphor
	x11-misc/wmctrl
	x11-misc/xtrlock"

#powermate.py from https://github.com/bethebunny/powermate

src_compile() {
	grcc -o "${S}" fosphor_knob_uhd.grc || die
	grcc -o "${S}" fosphor_knob_uhd_sponsors.grc || die
	grcc -o "${S}" fosphor_knob_hackrf_sweep.grc || die
	grcc -o "${S}" fosphor_knob_hackrf_sweep_sponsors.grc || die
	grcc -o "${S}" fosphor_knob_bladerf2.grc || die
	grcc -o "${S}" fosphor_knob_bladerf2_sponsors.grc || die
}

src_install() {
	insinto /usr/share/${PN}
	doins *.py *.grc
	newins scrolly2025-2026.png scrolly.png
	fperms +x /usr/share/${PN}/run.py
	fperms +x /usr/share/${PN}/fosphor_knob_uhd.py
	fperms +x /usr/share/${PN}/fosphor_knob_uhd_sponsors.py
	fperms +x /usr/share/${PN}/fosphor_knob_hackrf_sweep.py
	fperms +x /usr/share/${PN}/fosphor_knob_hackrf_sweep_sponsors.py
	fperms +x /usr/share/${PN}/fosphor_knob_bladerf2.py
	fperms +x /usr/share/${PN}/fosphor_knob_bladerf2_sponsors.py
	newbin fosphor_knob.sh fosphor_knob
	dosym fosphor_knob /usr/bin/fosphor_knob_sponsors
	dosym fosphor_knob /usr/bin/fosphor_knob_uhd
	dosym fosphor_knob /usr/bin/fosphor_knob_uhd_sponsors
	dosym fosphor_knob /usr/bin/fosphor_knob_hackrf_sweep
	dosym fosphor_knob /usr/bin/fosphor_knob_hackrf_sweep_sponsors
	dosym fosphor_knob /usr/bin/fosphor_knob_bladerf
	dosym fosphor_knob /usr/bin/fosphor_knob_bladerf_sponsors
}
