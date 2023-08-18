# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="RTL88{3,5}2BU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/morrownr/rtl8852bu.git"
	#EGIT_BRANCH="1.19.3"
else
	HASH_COMMIT="92c8f97ea24af1e4bacf5d8ae31a5152f2bfa98e"
	SRC_URI="https://github.com/morrownr/rtl8852bu/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"

	S="${WORKDIR}/rtl8852bu-${HASH_COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

# compile against selected (not running) target
pkg_setup() {
	if use kernel_linux; then
		linux-mod-r1_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	sed -i 's#-DCONFIG_IEEE80211W#-DCONFIG_IEEE80211W -DCONFIG_RTW_80211R#' Makefile || die
	default
}

src_compile() {
	local modlist=( 8852bu=misc )
	local modargs=( KVER="${KV_FULL}" KSRC="${KERNEL_DIR}" )
	USER_EXTRA_CFLAGS="${CFLAGS} -Wno-error=designated-init -Wno-error=incompatible-pointer-types" linux-mod-r1_src_compile
}
