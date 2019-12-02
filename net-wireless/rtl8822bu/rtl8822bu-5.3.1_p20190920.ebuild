# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

DESCRIPTION="RTL88x2BU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/EntropicEffect/rtl8822bu.git"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EntropicEffect/rtl8822bu.git"
else
	HASH_COMMIT="683af4d8d36950a45e563cad255780cb994c5e4b"
	SRC_URI="https://github.com/EntropicEffect/rtl8822bu/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/rtl8822bu-${HASH_COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

# compile against selected (not running) target
pkg_setup() {
	if use kernel_linux; then
		BUILD_TARGETS="clean modules"
		MODULE_NAMES="88x2bu(misc:)"
		BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR}"

		linux-mod_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	sed -i 's#CONFIG_80211W = n#CONFIG_80211W = y#' Makefile || die
	sed -i 's#-DCONFIG_IEEE80211W#-DCONFIG_IEEE80211W -DCONFIG_RTW_80211R#' Makefile || die

	default
}
