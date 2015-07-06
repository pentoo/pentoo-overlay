# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit git-r3 udev distutils-r1 multilib

DESCRIPTION="command line rfid interface"
HOMEPAGE="https://github.com/ApertureLabsLtd/RFIDler.git"
EGIT_REPO_URI="https://github.com/ApertureLabsLtd/RFIDler.git"
EGIT_COMMIT="b30180f973491813f22e2fe910f94e9e2a480a91"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev"

DEPEND=""
RDEPEND="dev-python/pyserial
	dev-python/matplotlib"

S="${WORKDIR}/${P}/python"

src_install() {
	distutils-r1_src_install
	udev_dorules "${WORKDIR}/${P}/linux-support/71-rfidler-lf-cdc-blacklist.rules"
	insinto /usr/share/${PN}/
	doins "${WORKDIR}/${P}"/firmware/Pic32/RFIDler.X/dist/debug/production/RFIDler.X.production.hex
}
pkg_postinst() {
	udev_reload
	einfo "Firmware has been installed in /usr/share/${PN} and can be installed with dev-embedded/mphidflash"
	einfo "Depending on your hardware, you might have the following new devices:"
	einfo "/dev/RFIDlerBL"
	einfo "/dev/RFIDler"
	einfo "/dev/ttyACM0 (if the provided udev rule does not see the device)"
}
