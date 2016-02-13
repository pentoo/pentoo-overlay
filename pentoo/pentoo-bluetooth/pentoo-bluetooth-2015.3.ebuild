# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo bluetooth meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE=""

PDEPEND="
	app-fuzz/bss
	net-wireless/bt-audit
	net-wireless/btscanner
	net-wireless/crackle
	net-wireless/kismet-ubertooth
	|| ( <=net-libs/libbtbb-2015.10.1 net-libs/libbtbb[wireshark-plugins] )
	net-wireless/ubertooth
	net-wireless/haraldscan
	>=net-wireless/blueman-1.23_p20140717"
