# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit git-r3

DESCRIPTION="Tools for developers working on broadcom drivers/firmware"
HOMEPAGE="http://bues.ch/cms/hacking/misc.html#linux_b43_driver_firmware_tools"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mbuesch/b43-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+assembler debug disassembler +ssb_sprom"

RDEPEND="net-wireless/b43-fwcutter"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {

	if use assembler; then
		cd "${S}"/assembler
		emake
	fi

	if use disassembler; then
		cd "${S}"/disassembler
		emake
	fi

	if use ssb_sprom; then
		cd "${S}"/ssb_sprom
		emake
	fi
}

src_install() {
	if use assembler; then
		dobin "${S}"/assembler/b43-asm.bin
		sed -e 's/installed=0/installed=1/' -i "${S}"/assembler/b43-asm
		dobin "${S}"/assembler/b43-asm
	fi

## install debug, I'm guessing this needs a few deps, and what not
	if use debug; then
		cd "${S}"/debug
		insinto /usr/lib/python2.7/
		doins libb43.py
		dobin b43-beautifier b43-fwdump patcher-template
	fi

	if use disassembler; then
		dobin "${S}"/disassembler/b43-dasm
		dobin "${S}"/disassembler/b43-ivaldump
	fi

	if use ssb_sprom; then
		dobin "${S}"/ssb_sprom/ssb-sprom
	fi

	einfo "The docs are not packaged properly if you use dodoc README several times, feel free to fix it"
}
