# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	#EGIT_REPO_URI="https://github.com/Gateworks/nrc7292.git"
	#S="${WORKDIR}/${P}/package/host/nrc_driver/source/nrc_driver/nrc"
	EGIT_REPO_URI="https://github.com/newracom/nrc7292_sw_pkg.git"
	S="${WORKDIR}/${P}/package/host/src/nrc"
else
	SRC_URI="https://github.com/newracom/nrc7292_sw_pkg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	#KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/nrc7292_sw_pkg-${PV}/package/host/nrc_driver/source/nrc_driver/nrc"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

DEPEND=""

# compile against selected (not running) target
pkg_setup() {
	if use kernel_linux; then
		BUILD_TARGETS="clean modules"
		MODULE_NAMES="nrc7292(misc:)"
		BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR} V=1"

		linux-mod_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	sed -i 's# -Werror##' Makefile || die

	default
}
