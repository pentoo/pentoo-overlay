# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header

inherit git
SRC_URI=""
EGIT_REPO_URI="http://git.bu3sch.de/git/b43-tools.git"

DESCRIPTION="Tools for developers working on broadcom drivers/firmware"
HOMEPAGE="http://bu3sch.de/gitweb?p=b43-tools.git;a=summary"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+assembler debug disassembler fwcutter +ssb_sprom"

EAPI=2

#debug will have extra rdeps
#consider importing the python stuff and doing the postinst whatnot

DEPEND="fwcutter? ( && ( !net-wireless/b43-fwcutter ) ( net-wireless/broadcom-firmware-downloader ) )"
RDEPEND="${DEPEND}"

src_compile() {

    if use assembler; then
        cd ${S}/assembler
        emake || die "emake assembler failed"
    fi

## ?
    if use debug; then
        einfo "someone please fix the debug flag"
#        cd ${S}/debug
#            emake || die "emake failed"
    fi

    if use disassembler; then
        cd ${S}/disassembler
        emake || die "emake disassembler failed"
    fi

    if use fwcutter; then
        cd ${S}/fwcutter
        emake || die "emake fwcutter failed"
    fi

    if use ssb_sprom; then
        cd ${S}/ssb_sprom
        emake || die "emake ssb_sprom failed"
    fi
}

src_install() {
    if use assembler; then
        dobin ${S}/assembler/b43-asm.bin
        sed -e 's/installed=0/installed=1/' -i ${S}/assembler/b43-asm
        dobin ${S}/assembler/b43-asm
    fi

## install debug, I'm guessing this needs a few deps, and what not
    if use debug; then
         einfo "currently the debug flag does NOTHING"
#        cd ${S}/debug
    fi

    if use disassembler; then
        dobin ${S}/disassembler/b43-dasm
        dobin ${S}/disassembler/b43-ivaldump
    fi

    if use fwcutter; then
        dobin ${S}/fwcutter/b43-fwcutter
        doman ${S}/fwcutter/b43-fwcutter.1
    fi

    if use ssb_sprom; then
        dobin ${S}/ssb_sprom/ssb-sprom
    fi

    einfo "The docs are not packaged properly if you use dodoc README several times, feel free to fix it"
}
