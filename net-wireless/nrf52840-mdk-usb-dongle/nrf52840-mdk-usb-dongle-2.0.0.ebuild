# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firmwares for Makerdiary nrf52840 and compatible usb dongles"
HOMEPAGE="https://github.com/makerdiary/nrf52840-mdk-usb-dongle"
SRC_URI="https://github.com/makerdiary/nrf52840-mdk-usb-dongle/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}/${P}/firmware"

src_install() {
	insinto "/usr/share/makerdiary/${PN}"
	doins -r *
}
