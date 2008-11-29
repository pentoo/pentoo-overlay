# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/bss/bss-0.6.ebuild,v 1.1.1.1 2006/03/29 14:43:43 grimmlin Exp $

DESCRIPTION="Bluetooth stack smasher / fuzzer"
HOMEPAGE="http://www.secuobs.com/news/05022006-bluetooth10.shtml"
SRC_URI="http://www.secuobs.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="net-wireless/bluez-libs"

src_compile() {
	sed -i -e 's/\/local//g' Makefile
	make || die "Make failed"
	cd replay_packet
	sed -i -e 's/\/local//g' Makefile
	make || die "Make failed"
}

src_install() {
	dobin bss replay_packet/replay_l2cap_packet
	dodoc AUTHORS README BUGS TODO
	if use doc; then
		dodoc doc/*
	fi
}
