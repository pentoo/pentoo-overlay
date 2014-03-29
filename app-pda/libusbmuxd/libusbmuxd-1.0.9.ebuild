# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools

DESCRIPTION="A client library to multiplex connections from and to iOS devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="virtual/libusb:1
	!<app-pda/usbmuxd-1.0.8_p20140325"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README
}
