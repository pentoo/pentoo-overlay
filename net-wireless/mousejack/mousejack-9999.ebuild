# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )
inherit python-single-r1

DESCRIPTION="Firmware and research tools for nRF24LU1+ based USB dongles and breakout boards"
HOMEPAGE="https://www.mousejack.com/"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kuzmin-no/nrf-research-firmware-python3.git"
else
	COMMIT="e4de36685d9f9161430e724ce0e63f8c850e0fba"
	SRC_URI="https://github.com/kuzmin-no/nrf-research-firmware-python3/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/nrf-research-firmware-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
REQUIRED_USE=${PYTHON_REQUIRED_USE}

DEPEND="dev-embedded/sdcc[device-lib,mcs51]"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-embedded/platformio[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/pyusb[${PYTHON_USEDEP}]
	')"

src_prepare() {
	mv tools/lib tools/nrf24 || die
	# This is needed, qa warning is false because this is a no-op on tools/nrf24-reset-radio.py
	for file in tools/nrf24-*; do
		sed -i 's#from lib#from nrf24#' ${file} || die
	done
	default
}
src_install() {
	insinto /usr/share/${PN}
	doins bin/dongle.{bin,formatted.bin,formatted.ihx}

	python_domodule tools/nrf24
	python_doscript tools/nrf24-*

	python_scriptinto /usr/share/${PN}/prog
	python_doscript prog/usb-flasher/usb-flash.py
	python_doscript prog/usb-flasher/logitech-usb-flash.py
	python_doscript prog/usb-flasher/unifying.py

	dosbin "${FILESDIR}/mousejack"
}
