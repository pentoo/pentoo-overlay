# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="The ultimate disassembler library (X86-32, X86-64)"
HOMEPAGE="http://www.ragestorm.net/distorm/"
SRC_URI="http://ragestorm.net/distorm/${PN}64-pkg${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND="python? ( >=dev-lang/python-2.4 )"

src_unpack() {
    unpack ${A}
}

src_compile() {
    cd "${WORKDIR}/${PN}64/build/linux"

    emake clib || die "make clib failed!"

    if use python; then
        emake py || die "make py failed!"
    fi
}

src_install() {
    cd "${WORKDIR}/${PN}64/build/linux"

    dolib.so libdistorm64.so

    if use python; then
	if has_version ">=dev-lang/python-2.5"; then
            mkdir -p ${D}usr/lib/python2.5/site-packages/
	    install libdistorm64.so ${D}usr/lib/python2.5/site-packages/distorm.so
	else	
            mkdir -p ${D}usr/lib/python2.4/site-packages/
	    install libdistorm64.so ${D}usr/lib/python2.4/site-packages/distorm.o
	fi
    fi

    cd "${WORKDIR}/${PN}64/"
    mv distorm64.a libdistorm64.a
    dolib.a libdistorm64.a

    mkdir -p ${D}usr/include
    install distorm.h ${D}usr/include/ || die "Unable to install distorm.h"
}
