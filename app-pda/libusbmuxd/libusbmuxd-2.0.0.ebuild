# Copyright 1999-2019 Pentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/libusbmuxd/archive/${PV}.tar.gz -> ${P}.tar.gz"

# tools/iproxy.c is GPL-2+, everything else is LGPL-2.1+
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/2" # based on SONAME of libusbmuxd.so
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="kernel_linux static-libs"

RDEPEND=">=app-pda/libplist-2.1:=
	virtual/libusb:1
	!=app-pda/usbmuxd-1.0.9
	!<app-pda/usbmuxd-1.0.8_p1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

#DOCS=( AUTHORS README )

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
	eautoreconf
	eapply_user
}

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use kernel_linux || myeconfargs+=( --without-inotify )

	econf "${myeconfargs[@]}"
}
