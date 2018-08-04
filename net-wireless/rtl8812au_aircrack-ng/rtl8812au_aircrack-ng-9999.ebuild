# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod git-r3

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"
EGIT_REPO_URI="https://github.com/aircrack-ng/rtl8812au.git"
EGIT_BRANCH="v5.2.20"

if [[ ${PV} == "9999" ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="2bf997aed79acbe019a2bed45cb18cd209cd5401"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="!!net-wireless/rtl8812au_astsam
	!!net-wireless/rtl8812au
	!!net-wireless/rtl8812au_asus"

MODULE_NAMES="8812au(net/wireless:) 8814au(net/wireless:)"

#compile against selected (not running) target
pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KVER=${KV_FULL}"
}

src_prepare() {
	sed -i 's#CONFIG_80211W = n#CONFIG_80211W = y#' Makefile
	default
}

src_compile() {
	set_arch_to_kernel
	KVER="${KV_FULL}" emake V=1 clean
	KVER="${KV_FULL}" emake V=1
	#https://github.com/aircrack-ng/rtl8812au/issues/157
	#https://github.com/aircrack-ng/rtl8812au/issues/158
	#https://github.com/aircrack-ng/rtl8812au/issues/159
	#mv 8812au.ko 8812au.protected
	#KVER="${KV_FULL}" emake V=1 clean
	#mv 8812au.protected 8812au.ko
	#sed -i 's#CONFIG_RTL8821A = y#CONFIG_RTL8821A = n#' Makefile
	#sed -i 's#CONFIG_RTL8812A = y#CONFIG_RTL8812A = n#' Makefile
	#sed -i 's#CONFIG_RTL8814A = y#CONFIG_RTL8814A = n#' Makefile
	#KVER="${KV_FULL}" emake V=1 RTL8814=1
}
