# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="BED is a multi-protocol fuzzer written in perl"
HOMEPAGE="https://www.aldeid.com/wiki/Bed"
SRC_URI="http://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	exeinto /opt/bed/
	doexe bed.pl
	insinto /opt/bed/bedmod/
	doins bedmod/*
	dosbin "${FILESDIR}"/bed
}
