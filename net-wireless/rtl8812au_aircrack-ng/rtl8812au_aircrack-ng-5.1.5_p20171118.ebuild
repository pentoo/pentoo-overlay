# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod git-r3

DESCRIPTION="RTL8812AU/21AU and RTL8814AU driver with monitor mode and frame injection"
HOMEPAGE="https://github.com/astsam/rtl8812au"
EGIT_REPO_URI="https://github.com/aircrack-ng/rtl8812au.git"
EGIT_COMMIT="866b187311a1823b53218b0a073fc4f011cbda94"
EGIT_BRANCH="v5.1.5"

#/include/rtw_version.h
#DRIVERVERSION "v5.1.5_19247.20160830"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ARCH=x86_64
MODULE_NAMES="8812au(net/wireless:)"
BUILD_TARGETS="clean modules"
