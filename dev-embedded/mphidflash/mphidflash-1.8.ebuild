# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Tool for communicating with the USB-Bootloader in PIC microcontrollers"
HOMEPAGE="https://github.com/ApertureLabsLtd/mphidflash"
#SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${P}-src.tar.gz"
#https://github.com/ApertureLabsLtd/mphidflash/issues/23
SRC_URI="https://github.com/ApertureLabsLtd/mphidflash/raw/master/dist/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:0
	dev-libs/libhid"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-makefile.patch
	default
}

src_compile() {
	use x86 && emake mphidflash32
	use amd64 && emake mphidflash64
}

src_install() {
	use x86 && newbin ${P}-linux-32 ${PN}
	use amd64 && newbin ${P}-linux-64 ${PN}
}
