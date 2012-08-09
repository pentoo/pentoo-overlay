# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/bed/bed-0.5.ebuild,v 1.1.1.1 2006/03/08 00:40:08 grimmlin Exp $

DESCRIPTION="BED is a multi-protocol fuzzer written in perl"
HOMEPAGE="http://www.snake-basket.de/bed.html"
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
