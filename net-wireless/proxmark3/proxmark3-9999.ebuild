# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RfidResearchGroup/proxmark3.git"
else
	HASH_COMMIT="1ac5211601b50b82b41737dce0c3a72d9e0374ac"
	SRC_URI="https://github.com/RfidResearchGroup/${PN}/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/${PN}-${HASH_COMMIT}
fi
DESCRIPTION="A general purpose RFID tool for Proxmark3 hardware"
HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"

LICENSE="GPL-2"
SLOT="0"
STANDALONE="+standalone-lf-samyrun standalone-lf-proxbrute standalone-lf-hidbrute standalone-hf-young standalone-hf-mattyrun standalone-hf-colin standalone-hf-bog"
IUSE="deprecated +firmware +pm3rdv4 ${STANDALONE}"
REQUIRED_USE="?? ( ${STANDALONE/+/} )
			standalone-hf-colin? ( pm3rdv4 )
			standalone-hf-bog? ( pm3rdv4 )"

RDEPEND="virtual/libusb:0
	sys-libs/ncurses:*[tinfo]
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	sys-libs/readline:="
DEPEND="${RDEPEND}
	firmware? ( sys-devel/gcc-arm-none-eabi:0 )"

QA_FLAGS_IGNORED="usr/share/proxmark3/firmware/bootrom.elf
				usr/share/proxmark3/firmware/fullimage.elf"

src_compile(){
	#first we set platform
	if use pm3rdv4; then
		echo 'PLATFORM=PM3RDV4' > Makefile.platform
		echo 'PLATFORM_EXTRAS=BTADDON' >> Makefile.platform
	else
		echo 'PLATFORM=PM3OTHER' > Makefile.platform
	fi
	#then we set a standalone mode
	if use standalone-lf-samyrun; then
		echo 'STANDALONE=LF_SAMYRUN' >> Makefile.platform
	elif use standalone-lf-proxbrute; then
		echo 'STANDALONE=LF_PROXBRUTE' >> Makefile.platform
	elif use standalone-lf-hidbrute; then
		echo 'STANDALONE=LF_HIDBRUTE' >> Makefile.platform
	elif use standalone-hf-young; then
		echo 'STANDALONE=HF_YOUNG' >> Makefile.platform
	elif use standalone-hf-mattyrun; then
		echo 'STANDALONE=HF_MATTYRUN' >> Makefile.platform
	elif use standalone-hf-colin; then
		echo 'STANDALONE=HF_COLIN' >> Makefile.platform
	elif use standalone-hf-bog; then
		echo 'STANDALONE=HF_BOG' >> Makefile.platform
	else
		echo 'STANDALONE=' >> Makefile.platform
	fi

	export PM3_SHARE_PATH=/usr/share/${PN}
	export V=1
	if use firmware; then
		emake all
	elif use deprecated; then
		emake client/proxmark3 mfkey nonce2key
	else
		emake client/proxmark3
	fi
}

src_install(){
	dobin client/proxmark3
	if use deprecated; then
		#install some tools
		exeinto /usr/share/proxmark3/tools
		doexe tools/mfkey/mfkey{32,64}
		#doexe tools/mfkey32v2
		doexe tools/nonce2key/nonce2key
	fi
	#install main lua and scripts
	insinto /usr/share/proxmark3/lualibs
	doins client/lualibs/*
	insinto /usr/share/proxmark3/luascripts
	doins client/luascripts/*
	insinto /usr/share/proxmark3/dictionaries
	doins client/dictionaries/*
	insinto /usr/share/proxmark3/hardnested
	doins client/hardnested/*
	insinto /usr/share/proxmark3/traces
	doins traces/*
	if use firmware; then
		exeinto /usr/share/proxmark3/firmware
		doexe client/flasher
		insinto /usr/share/proxmark3/firmware
		doins armsrc/obj/fullimage.elf
		doins bootrom/obj/bootrom.elf
		doins tools/simmodule/SIM011.*
		newins tools/simmodule/readme.txt sim-update-readme.txt
		insinto /usr/share/proxmark3/jtag
		doins recovery/*.bin
	fi
	udev_dorules driver/77-pm3-usb-device-blacklist.rules
}

pkg_postinst() {
	if use firmware; then
		einfo "flasher is located in /usr/share/proxmark3/firmware/"
		if use pm3rdv4; then
			ewarn "Please note, all firmware and recovery files are intended for the Proxmark3 RDV4"
			ewarn "including support for the optional blueshark accessory."
			ewarn "If this is not what you intended please unset the pm3rdv4 use flag for generic firmware"
		else
			ewarn "Please note, all firmware and recovery files are built for a generic target."
			ewarn "If you have a Proxmark3 RDV4 you should set the pm3rdv4 use flag for an improved firmware"
		fi
	fi
}
