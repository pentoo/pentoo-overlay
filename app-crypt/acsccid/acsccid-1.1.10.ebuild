# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools udev

DESCRIPTION="Generic driver for ACS (CCID and non-CCID) Smart Card Reader"
HOMEPAGE="http://acsccid.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="
	sys-apps/pcsc-lite[udev]
	virtual/libusb:1
	!app-crypt/ccid
	!app-crypt/acr38u"

DEPEND="${RDEPEND}
	sys-devel/flex"

BDEPEND="virtual/pkgconfig"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	udev_newrules "${FILESDIR}"/92-pcsc-acsccid.rules 92-pcsc-acsccid.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
