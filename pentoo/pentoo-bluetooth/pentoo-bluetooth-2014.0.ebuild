# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo bluetooth meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-fuzz/bss
	net-wireless/bt-audit
	net-wireless/btscanner
	net-wireless/kismet-ubertooth
	net-libs/libbtbb[wireshark]
	net-wireless/ubertooth
	net-wireless/haraldscan
	net-wireless/gnome-bluetooth"
