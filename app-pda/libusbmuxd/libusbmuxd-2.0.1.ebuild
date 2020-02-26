# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="https://www.libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/libusbmuxd/archive/${PV}.tar.gz -> ${P}.tar.gz"

# tools/iproxy.c is GPL-2+, everything else is LGPL-2.1+
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/6.0.0" # based on SONAME of libusbmuxd.so
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="kernel_linux static-libs"

RDEPEND="
	app-pda/libplist:=
	virtual/libusb:1
	!=app-pda/usbmuxd-1.0.9*
	!<app-pda/usbmuxd-1.0.8_p1"
DEPEND="${RDEPEND}
	virtual/os-headers"
BDEPEND="virtual/pkgconfig"

#DOCS=( AUTHORS README )

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh || die
	eautoreconf
	default
}

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use kernel_linux || myeconfargs+=( --without-inotify )

	econf "${myeconfargs[@]}"
}
