# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info linux-mod

ASUS_PV="linux_v4.3.13_14061.20150505"

DESCRIPTION="Driver for the ASUS USB AC56 (801.11ac) wireless adapter"
HOMEPAGE="http://www.asus.com/Networking/USBAC56/"
SRC_URI="http://dlm3cdnet.asus.com/pub/ASUS/wireless/USB-AC56/DR_USB_AC56_4314_Linux.zip
	http://dlcdnet.asus.com/pub/ASUS/wireless/USB-AC56/DR_USB_AC56_4314_Linux.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ARCH=x86_64
MODULE_NAMES="8812au(net/wireless:)"
BUILD_TARGETS="clean modules"

src_unpack() {
	unpack ${A}
	unpack ./RTL8812AU_${ASUS_PV}/driver/rtl8812AU_${ASUS_PV}.tar.gz
}

S="${WORKDIR}"/rtl8812AU_${ASUS_PV}

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -gt 3 18 && die "kernel higher then 3.18.0 is not supported by this version"
}

#src_prepare() {
#	use pax_kernel && epatch "${FILESDIR}"/rtl8812au_grsecurity.patch
#}
