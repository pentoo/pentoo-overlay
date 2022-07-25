# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-any-r1

DESCRIPTION="nRF Sniffer for Bluetooth LE"
HOMEPAGE="https://www.nordicsemi.com/Products/Development-tools/nRF-Sniffer-for-Bluetooth-LE"
SRC_URI="https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-Sniffer/sw/nrf_sniffer_for_bluetooth_le_4.1.0.zip -> ${P}.zip"
KEYWORDS="amd64 arm arm64 x86"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"

DEPEND="net-analyzer/wireshark
		${PYTHON_DEPS}"
RDEPEND="${DEPEND}
		$(python_gen_any_dep 'dev-python/pyserial[${PYTHON_USEDEP}]')"
BDEPEND=""

src_install() {
	insinto /usr/share/${PN}
	doins "hex/sniffer_nrf51dk_nrf51422_${PV}.hex"
	doins "hex/sniffer_nrf52833dk_nrf52833_${PV}.hex"
	doins "hex/sniffer_nrf52840dongle_nrf52840_${PV}.hex"
	doins "hex/sniffer_nrf51dongle_nrf51422_${PV}.hex"
	doins "hex/sniffer_nrf52840dk_nrf52840_${PV}.hex"
	doins "hex/sniffer_nrf52dk_nrf52832_${PV}.hex"

	exeinto "/usr/$(get_libdir)/wireshark/extcap"
	doexe extcap/nrf_sniffer_ble.py
	insinto "/usr/$(get_libdir)/wireshark/extcap"
	doins -r extcap/SnifferAPI
}
