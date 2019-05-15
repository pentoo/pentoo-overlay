# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aircrack-ng/rtl8812au.git"
	EGIT_BRANCH="v5.2.20"
else
	#KEYWORDS="~amd64 ~x86"
	COMMIT="4c63f21cd7f585421a0f4ab16af8112b25485bae"
	SRC_URI="https://github.com/aircrack-ng/rtl8812au/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/rtl8812au-${COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

DEPEND="!!net-wireless/rtl8812au_astsam
	!!net-wireless/rtl8812au
	!!net-wireless/rtl8812au_asus"

BUILD_TARGETS="clean modules"
MODULE_NAMES="88XXau(misc:)"

#compile against selected (not running) target
pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR} RTL8814=1"
}

src_prepare() {
	sed -i 's#CONFIG_80211W = n#CONFIG_80211W = y#' Makefile
	sed -i 's#-DCONFIG_IEEE80211W#-DCONFIG_IEEE80211W -DCONFIG_RTW_80211R#' Makefile
	default
}
