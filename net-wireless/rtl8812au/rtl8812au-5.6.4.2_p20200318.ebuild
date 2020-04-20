# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info linux-mod git-r3

#include/rtw_version.h
DESCRIPTION="Linux kernel driver for rtl8812au USB WiFi chipsets"
HOMEPAGE="https://github.com/gordboy/rtl8812au-5.6.4.2"
EGIT_REPO_URI="https://github.com/gordboy/rtl8812au-5.6.4.2.git"
EGIT_COMMIT="49e98ff9bfdbe2ddce843808713de383132002e0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ARCH=x86_64
MODULE_NAMES="8812au(net/wireless:)"
BUILD_TARGETS="clean modules"
DEPEND="!!net-wireless/rtl8812au_astsam
	!!net-wireless/rtl8812au_aircrack-ng"

pkg_setup() {
	linux-mod_pkg_setup
	#compile against selected (not running) target
	BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR}"
}
