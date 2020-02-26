# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

HASH_COMMIT="1ac5211601b50b82b41737dce0c3a72d9e0374ac"

DESCRIPTION="A general purpose RFID tool for Proxmark3 hardware"
HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"
SRC_URI="https://github.com/RfidResearchGroup/${PN}/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="deprecated +firmware"

#fpga_compress fails to compile
#MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND="virtual/libusb:0
	sys-libs/ncurses:*[tinfo]
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	sys-libs/readline:=
	dev-util/astyle"
DEPEND="${RDEPEND}
	firmware? ( sys-devel/gcc-arm-none-eabi )"

S=${WORKDIR}/${PN}-${HASH_COMMIT}

src_prepare() {
	sed -i -e 's/-ltermcap/-ltinfo/g' client/Makefile || die
	sed -i -e 's/-ltermcap/-ltinfo/g' client/liblua/Makefile || die
	sed -i -e 's#lualibs/#../../usr/share/proxmark3/lualibs/#' client/scripting.h || die
	sed -i -e 's#scripts/#../../usr/share/proxmark3/scripts/#' client/scripting.h || die
	sed -i -e 's#mkdir#mkdir -p#' Makefile.host || die
	eapply_user
}

src_compile(){
	if use firmware; then
		# platform should be an exclusive use flag, extras should default to btaddon for pm3rdv4
		# standalone should also be an exclusive use flag
		emake V=1 PLATFORM=PM3RDV4 PLATFORM_EXTRAS=BTADDON all
	elif use deprecated; then
		emake V=1 client/proxmark3 mfkey nonce2key
	else
		emake V=1 client/proxmark3
	fi
}

src_install(){
	dobin client/proxmark3
	if use deprecated; then
		#install some tools
		exeinto /usr/share/proxmark3/tools
		doexe tools/mfkey/mfkey{32,64}
		doexe tools/nonce2key/nonce2key
	fi
	#install main lua and scripts
	insinto /usr/share/proxmark3/lualibs
	doins client/lualibs/*
	insinto /usr/share/proxmark3/scripts
	doins client/scripts/*
	if use firmware; then
		exeinto /usr/share/proxmark3/firmware
		doexe client/flasher
		insinto /usr/share/proxmark3/firmware
		doins armsrc/obj/fullimage.elf
		doins bootrom/obj/bootrom.elf
		insinto /usr/share/proxmark3/jtag
		doins recovery/*.bin
	fi
	udev_dorules driver/77-pm3-usb-device-blacklist.rules
}

pkg_postinst() {
	if use firmware; then
		einfo "flasher is located in /usr/share/proxmark3/firmware/"
		ewarn "Please note, all firmware and recovery files are intended for the Proxmark3 RDV4"
	fi
}
