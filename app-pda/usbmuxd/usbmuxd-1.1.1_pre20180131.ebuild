# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools udev user git-r3

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
#SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

EGIT_REPO_URI="https://github.com/libimobiledevice/usbmuxd.git"
EGIT_COMMIT="b888970f68fb16961a7cc3a526065fab7a5d96ca"

# src/utils.h is LGPL-2.1+, rest is found in COPYING*
LICENSE="GPL-2 GPL-3 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="systemd"

RDEPEND=">=app-pda/libimobiledevice-1.1.7
	>=app-pda/libplist-1.12
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure(){
	use systemd && ewarn "systemd functionally was not tested. Please report bugs if any"
	econf $(use_with systemd)
}
