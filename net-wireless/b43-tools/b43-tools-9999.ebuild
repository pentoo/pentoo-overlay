# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git-2 python

DESCRIPTION="Tools for developers working on broadcom drivers/firmware"
HOMEPAGE="http://bu3sch.de/gitweb?p=b43-tools.git;a=summary"
SRC_URI=""
EGIT_REPO_URI="git://git.bues.ch/b43-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+assembler debug disassembler fwcutter +ssb_sprom"

RDEPEND="fwcutter? ( net-wireless/b43-fwcutter )"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {

	if use assembler; then
		cd "${S}"/assembler
		emake || die "emake assembler failed"
	fi

	if use disassembler; then
		cd "${S}"/disassembler
		emake || die "emake disassembler failed"
	fi

	if use fwcutter; then
	einfo "Firmware cutter from b43-tools will NOT be installed. Use net-wireless/b43-fwcutter instead."
#        cd "${S}"/fwcutter
#        emake || die "emake fwcutter failed"
	fi

	if use ssb_sprom; then
		cd "${S}"/ssb_sprom
		emake || die "emake ssb_sprom failed"
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
		insinto /usr/lib/python$(python_get_version)/
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
