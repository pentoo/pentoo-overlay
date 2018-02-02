# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools git-r3

EGIT_REPO_URI="https://github.com/libimobiledevice/libusbmuxd.git"
EGIT_COMMIT="c724e70fb52ba45291dc73a2e369c0c5bae0ec2e"

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
#SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

# tools/iproxy.c is GPL-2+, everything else is LGPL-2.1+
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/2" # based on SONAME of libusbmuxd.so
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="kernel_linux static-libs"

RDEPEND=">=app-pda/libplist-1.12:=
	virtual/libusb:1
	!=app-pda/usbmuxd-1.0.9
	!<app-pda/usbmuxd-1.0.8_p1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

DOCS=( AUTHORS README )

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use kernel_linux || myeconfargs+=( --without-inotify )

	econf "${myeconfargs[@]}"
}
