# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info linux-mod git-r3

#include/rtw_version.h
DESCRIPTION="Driver for AC1200 (801.11ac) Wireless Dual-Band USB Adapter"
HOMEPAGE="https://github.com/abperiasamy/rtl8812AU_8821AU_linux"
EGIT_REPO_URI="https://github.com/abperiasamy/rtl8812AU_8821AU_linux.git"
EGIT_COMMIT="99fbe64d622955bf4a412ef653899226712497f5"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ARCH=x86_64
MODULE_NAMES="rtl8812au(net/wireless:)"
BUILD_TARGETS="clean modules"
