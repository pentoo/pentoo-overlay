# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.8-r1.ebuild,v 1.7 2013/02/02 22:23:47 ago Exp $

EAPI=5
inherit user udev git-2 autotools

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
#waiting for a release
#SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"
EGIT_REPO_URI="https://github.com/libimobiledevice/usbmuxd.git"
EGIT_COMMIT="1a57e4ad05fae295f2892e1aeae462cbaaded9a3"

LICENSE="GPL-2 GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=app-pda/libplist-1.11
	app-pda/libusbmuxd
	app-pda/libimobiledevice
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

DOCS="AUTHORS README"

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

src_prepare(){
	./autogen.sh
}

src_install() {
	emake DESTDIR="${D}" install
}
