# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A general purpose RFID tool for Proxmark3 hardware"
HOMEPAGE="https://github.com/Proxmark/proxmark3"
SRC_URI="https://github.com/Proxmark/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="virtual/libusb:0
	sys-libs/ncurses:*
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/-ltermcap/-ltinfo/g' client/Makefile || die
	sed -i -e 's/-ltermcap/-ltinfo/g' liblua/Makefile || die
	eapply_user
}

src_compile(){
	emake client
}

src_install(){
	dobin client/{flasher,proxmark3}
}
