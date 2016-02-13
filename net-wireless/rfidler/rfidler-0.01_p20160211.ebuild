# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit git-r3 udev distutils-r1 multilib

DESCRIPTION="Software defined RFID (LF) Reader/Writer/Emulator"
HOMEPAGE="https://github.com/ApertureLabsLtd/RFIDler"
EGIT_REPO_URI="https://github.com/ApertureLabsLtd/RFIDler.git"
EGIT_COMMIT="426dfcd5ffa94eb554f43996f49f3e9183a95e0a"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev +firmware"

DEPEND=""
RDEPEND="dev-python/pyserial
	dev-python/matplotlib
	firmware? ( dev-embedded/mphidflash )"

S="${WORKDIR}/${P}/python"

src_install() {
	distutils-r1_src_install
	udev_dorules "${WORKDIR}/${P}/linux-support/71-rfidler-lf-cdc-blacklist.rules"
	insinto /usr/share/${PN}/
	use firmware && doins "${WORKDIR}/${P}"/firmware/Pic32/RFIDler.X/dist/debug/production/RFIDler.X.production.hex
}

pkg_postinst() {
	udev_reload
	use firmware && einfo "Firmware has been installed in /usr/share/${PN} and can be installed with dev-embedded/mphidflash"
	einfo "Depending on your hardware, you might have the following new devices:"
	einfo "/dev/RFIDlerBL"
	einfo "/dev/RFIDler"
	einfo "/dev/ttyACM0 (if the provided udev rule does not see the device)"
}
