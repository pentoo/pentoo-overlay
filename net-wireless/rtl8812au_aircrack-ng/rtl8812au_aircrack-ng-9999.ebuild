# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aircrack-ng/rtl8812au.git"
	EGIT_BRANCH="v5.6.4.2"
else
	HASH_COMMIT="35308f4dd73e77fa572c48867cce737449dd8548"
	SRC_URI="https://github.com/aircrack-ng/rtl8812au/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"

	S="${WORKDIR}/rtl8812au-${HASH_COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

DEPEND="
	!!net-wireless/rtl8812au"

# compile against selected (not running) target
pkg_setup() {
	if use kernel_linux; then
		BUILD_TARGETS="clean modules"
		MODULE_NAMES="88XXau(misc:)"
		BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR} RTL8814=1 V=1"

		linux-mod_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	sed -i 's#CONFIG_80211W = n#CONFIG_80211W = y#' Makefile || die
	sed -i 's#-DCONFIG_IEEE80211W#-DCONFIG_IEEE80211W -DCONFIG_RTW_80211R#' Makefile || die
	sed -i 's#CONFIG_RTW_VIRTUAL_INTF = n#CONFIG_RTW_VIRTUAL_INTF = y#' Makefile || die
	default
}
