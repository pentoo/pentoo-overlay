# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

inherit linux-info linux-mod git-2

DESCRIPTION="rtl8812AU_8821AU linux kernel driver for AC1200 (801.11ac) Wireless Dual-Band USB Adapter"
HOMEPAGE="http://www.asus.com/Networking/USBAC56/"
EGIT_REPO_URI="https://github.com/abperiasamy/rtl8812AU_8821AU_linux.git"
EGIT_COMMIT="a32fae1668b364351962786f179a0cc5c1fc17f0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pax_kernel"

ARCH=x86_64
MODULE_NAMES="8812au(net/wireless:)"
BUILD_TARGETS="clean modules"

src_prepare() {
	use pax_kernel && epatch "${FILESDIR}"/rtl8812au_p2014_grsecurity.patch
}
