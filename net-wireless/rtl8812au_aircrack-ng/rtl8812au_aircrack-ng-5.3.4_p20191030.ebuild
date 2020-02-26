# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aircrack-ng/rtl8812au.git"
	EGIT_BRANCH="v5.3.4"
else
	KEYWORDS=""
	COMMIT="1887e5cbf772cd248a005eb687a5fd867fee41db"
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
	BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR} RTL8814=1 V=1"
}

src_prepare() {
	sed -i 's#CONFIG_80211W = n#CONFIG_80211W = y#' Makefile
	sed -i 's#-DCONFIG_IEEE80211W#-DCONFIG_IEEE80211W -DCONFIG_RTW_80211R#' Makefile
	default
}
