# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit udev

DESCRIPTION="A general purpose RFID tool for Proxmark3 hardware"
HOMEPAGE="https://github.com/Proxmark/proxmark3"
SRC_URI="https://github.com/Proxmark/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="firmware"

DEPEND="virtual/libusb:0
	sys-libs/ncurses:*
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	firmware? ( sys-devel/gcc-arm-none-eabi )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/-ltermcap/-ltinfo/g' client/Makefile || die
	sed -i -e 's/-ltermcap/-ltinfo/g' liblua/Makefile || die
	mv driver/77-mm-usb-device-blacklist.rules driver/77-pm3-usb-device-blacklist.rules
	eapply_user
}

src_compile(){
	if use firmware; then
		emake -j1 all
	else
		emake -j1 client
	fi
}

src_install(){
	dobin client/{flasher,proxmark3}
	if use firmware; then
		insinto /usr/share/proxmark3
		doins armsrc/obj/*.elf
		doins bootrom/obj/bootrom.elf
		doins recovery/*.bin
		doins tools/mfkey/mfkey{32,64}
	fi
	udev_dorules driver/77-pm3-usb-device-blacklist.rules
}
