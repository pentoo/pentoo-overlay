# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

inherit linux-info linux-mod

ASUS_PV="linux_v${PV}_10143.20140103_ASUS"

DESCRIPTION="Driver for the ASUS USB AC56 (801.11ac) wireless adapter"
HOMEPAGE="http://www.asus.com/Networking/USBAC56/"
SRC_URI="http://dlm3cdnet.asus.com/pub/ASUS/wireless/USB-AC56/DR_USB_AC56_425_Linux.zip
	http://dlcdnet.asus.com/pub/ASUS/wireless/USB-AC56/DR_USB_AC56_425_Linux.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pax_kernel"

S="${WORKDIR}"/rtl8812AU_${ASUS_PV}

ARCH=x86_64
MODULE_NAMES="8812au(net/wireless:)"
BUILD_TARGETS="clean modules"

src_unpack() {
	unpack ${A}
	unpack ./DR_USB_AC56_425_Linux/RTL8812AU_${ASUS_PV}.zip
	unpack ./RTL8812AU_${ASUS_PV}/driver/rtl8812AU_${ASUS_PV}.tar.gz
}

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -gt 3 10 && die "kernel higher then 3.10.0 is not supported by this version"
}

src_prepare() {
	use pax_kernel && epatch "${FILESDIR}"/rtl8812au_grsecurity.patch
}
