# Copyright 1999-2019 Pentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools udev user

HASH_COMMIT="1f8ddeff95884da404a7fbd74d27e04ca8c99a50"

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="https://www.libimobiledevice.org/"
#EGIT_REPO_URI="https://github.com/libimobiledevice/usbmuxd.git"
SRC_URI="https://github.com/libimobiledevice/usbmuxd/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

# src/utils.h is LGPL-2.1+, rest is found in COPYING*
LICENSE="GPL-2 GPL-3 LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="systemd"

RDEPEND="
	>=app-pda/libimobiledevice-1.2.1_pre
	app-pda/libplist:0=
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

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
