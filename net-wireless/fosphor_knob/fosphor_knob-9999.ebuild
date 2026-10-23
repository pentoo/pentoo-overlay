# Copyright 2019-2026 Gentoo Authors
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
	KEYWORDS="~amd64"
fi

#powermate.py from https://github.com/bethebunny/powermate
#powermate.py is Apache 2, the rest is GPL-3
LICENSE="GPL-3 Apache-2.0"
SLOT="0"

RDEPEND="net-wireless/gnuradio:=[qt6(+),uhd]
	net-analyzer/gr-fosphor
	>=net-wireless/gr-osmosdr-0.2.6_p20260130[bladerf]
	net-wireless/gr-paint
	>=net-wireless/bladerf-2025.10
	>=net-wireless/bladerf-firmware-2.6.0
	>=net-wireless/bladerf-fpga-0.16.0
	net-wireless/hackrf-tools
	net-wireless/uhd:=
	sys-apps/usbutils
	x11-misc/xdotool
	x11-misc/wmctrl
	x11-misc/xtrlock"
DEPEND="${RDEPEND}"
BDEPEND="net-wireless/gnuradio[grc]"

src_compile() {
	local grc
	for grc in *.grc; do
		grcc -o "${S}" "${grc}" || die "grcc failed on ${grc}"
	done
}

src_install() {
	insinto /usr/share/${PN}
	doins *.py *.grc nosleep.sh
	newins scrolly2026-2027.png scrolly.png
	fperms +x /usr/share/${PN}/nosleep.sh
	fperms +x /usr/share/${PN}/run.py
	local grc
	for grc in *.grc; do
		fperms +x "/usr/share/${PN}/${grc%.grc}.py"
	done
	newbin fosphor_knob.sh fosphor_knob
	dosym fosphor_knob /usr/bin/fosphor_knob_sponsors
	dosym fosphor_knob /usr/bin/fosphor_knob_uhd
	dosym fosphor_knob /usr/bin/fosphor_knob_uhd_sponsors
	dosym fosphor_knob /usr/bin/fosphor_knob_hackrf_sweep
	dosym fosphor_knob /usr/bin/fosphor_knob_hackrf_sweep_sponsors
	dosym fosphor_knob /usr/bin/fosphor_knob_bladerf
	dosym fosphor_knob /usr/bin/fosphor_knob_bladerf_sponsors
}
