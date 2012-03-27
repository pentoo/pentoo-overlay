# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit qt4-r2

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://aircrackgui-m4.googlecode.com/files/aircrack-GUI-M4%200.7.0%20Final-Source.tar.bz2 -> ${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.3
	>=x11-libs/qt-core-4.7.3"
RDEPEND="${DEPEND}
	net-analyzer/macchanger
	net-wireless/aircrack-ng"

S="${WORKDIR}/aircrack-GUI-M4 0.7.0 Final-Source"

src_prepare() {
	sed -i 's#aircrack-ng-1.1-M4/src/airodump-ng#/usr/sbin/airodump-ng#g' DEFINES.h
	sed -i 's#aircrack-ng-1.1-M4/src/aireplay-ng#/usr/sbin/aireplay-ng#g' DEFINES.h
	sed -i 's#aircrack-ng-1.1-M4/src/aircrack-ng#/usr/bin/aircrack-ng#g' DEFINES.h
	sed -i 's#binutils/macchanger#/usr/bin/macchanger#g' DEFINES.h
	#sed -i 's#airmon-ng#airmon-zc#g' DEFINES.h

	#I'm not 100% certain on if this will work but...
	sed -i 's#captures#/tmp/captures#g' DEFINES.h
	sed -i 's#arp_replays#/tmp/arp_replays#g' DEFINES.h
	sed -i 's#frag_caps#/tmp/frag_caps#g' DEFINES.h
	sed -i 's#chop_caps#/tmp/chop_caps#g' DEFINES.h
	sed -i 's#forged_arps#/tmp/forged_arps#g' DEFINES.h
	sed -i 's#broadcast_caps#/tmp/broadcast_caps#g' DEFINES.h
}

src_compile() {
	eqmake4 -config release
	emake
}

src_install() {
	dosbin aircrack-GUI
}
