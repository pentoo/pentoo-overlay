# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="ommand-line tool for communicating with the USB-Bootloader in PIC microcontrollers"
HOMEPAGE="https://code.google.com/p/mphidflash/"
#SRC_URI="https://mphidflash.googlecode.com/svn/trunk/dist/${P}-src.tar.gz"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb
	dev-libs/libhid"
RDEPEND="virtual/libusb"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-makefile.patch
}

src_compile() {
	use x86 && emake mphidflash32
	use amd64 && emake mphidflash64
}

src_install() {
	use x86 && newbin ${P}-linux-32 ${PN}
	use amd64 && newbin ${P}-linux-64 ${PN}
}
