# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib eutils udev

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86 ~arm"
DESCRIPTION="Generic driver for ACS (CCID and non-CCID) Smart Card Reader."

SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://acsccid.sourceforge.net/"

RDEPEND=">=sys-apps/pcsc-lite-1.8.3
	virtual/libusb:1
	!app-crypt/ccid
	!app-crypt/acr38u"
DEPEND="${RDEPEND}
	kernel_linux? ( virtual/pkgconfig )
	sys-devel/flex"

IUSE=""

src_install() {
	default

	if use kernel_linux; then
		udev_newrules "${FILESDIR}"/92-pcsc-acsccid.rules 92-pcsc-acsccid.rules
	fi
}

pkg_postinst() {
	udev_reload
}
