# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

DESCRIPTION="RTL88x2BU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/morrownr/88x2bu.git"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/morrownr/88x2bu.git"
else
	HASH_COMMIT="d57710b441e71c5dbdb0bc3daae05904a03b21e4"
	SRC_URI="https://github.com/morrownr/88x2bu/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/88x2bu-${HASH_COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

PATCHES=( "${FILESDIR}"/80211r.patch )

# compile against selected (not running) target
pkg_setup() {
	if use kernel_linux; then
		BUILD_TARGETS="clean modules"
		MODULE_NAMES="88x2bu(misc:)"
		BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR} V=1"

		linux-mod_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	#sed -i 's#CONFIG_80211W = n#CONFIG_80211W = y#' Makefile || die
	sed -i 's#-DCONFIG_IEEE80211W#-DCONFIG_IEEE80211W -DCONFIG_RTW_80211R#' Makefile || die

	default
}
