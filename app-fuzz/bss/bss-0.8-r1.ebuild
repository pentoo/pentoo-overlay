# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/bss/bss-0.6.ebuild,v 1.1.1.1 2006/03/29 14:43:43 grimmlin Exp $

DESCRIPTION="Bluetooth stack smasher / fuzzer"
HOMEPAGE="http://www.secuobs.com/news/15022006-bss_0_8.shtml"
SRC_URI="http://www.secuobs.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64" 
IUSE="doc"

DEPEND=" || ( net-wireless/bluez
	      net-wireless/bluez-libs )"

src_compile() {
	sed -i -e 's/\/local//g' Makefile
	emake || die "Make failed"
}

src_install() {
	dobin bss
	dodoc AUTHORS README BUGS TODO
	dodoc replay_packet/*
	if use doc; then
		dodoc doc/*
	fi
}
