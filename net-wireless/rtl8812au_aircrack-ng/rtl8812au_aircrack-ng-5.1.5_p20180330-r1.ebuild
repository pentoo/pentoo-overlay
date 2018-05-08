# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod git-r3

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"
EGIT_REPO_URI="https://github.com/aircrack-ng/rtl8812au.git"
EGIT_BRANCH="v5.1.5"

if [[ ${PV} == "9999" ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="af8fa990a6548159980e6656bfdc57e5a9c83c41"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="!!net-wireless/rtl8812au_astsam"

MODULE_NAMES="8812au(net/wireless:) 8814au(net/wireless:)"

#compile against selected (not running) target
pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KVER=${KV_FULL}"
}

src_compile() {
	set_arch_to_kernel
	emake clean
	emake
	emake RTL8814=1
}
