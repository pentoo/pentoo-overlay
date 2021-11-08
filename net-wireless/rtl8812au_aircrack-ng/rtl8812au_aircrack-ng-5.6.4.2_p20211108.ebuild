# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aircrack-ng/rtl8812au.git"
	EGIT_BRANCH="v5.6.4.2"
else
	HASH_COMMIT="307d694076b056588c652c2bdaa543a89eb255d9"
	SRC_URI="https://github.com/aircrack-ng/rtl8812au/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/rtl8812au-${HASH_COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

DEPEND="
	!!net-wireless/rtl8812au
	!!net-wireless/rtl8812au_asus
	!!net-wireless/rtl8812au_astsam"

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
	#these are not 88xxau devices
	#https://github.com/aircrack-ng/rtl8812au/issues/492
	sed -i '/0x0115/d' os_dep/linux/usb_intf.c || die

	default
}
