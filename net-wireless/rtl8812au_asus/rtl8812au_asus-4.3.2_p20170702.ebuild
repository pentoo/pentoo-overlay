# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info linux-mod git-r3

DESCRIPTION="Linux kernel module for ASUS USB-AC56"
HOMEPAGE="https://github.com/codeworkx/rtl8812au_asus/commits/master"
EGIT_REPO_URI="https://github.com/codeworkx/rtl8812au_asus.git"
EGIT_COMMIT="b098b2b0d1fa7ff515f95bf2f237fd698d1cd71f"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#IUSE="pax_kernel"

ARCH=x86_64
MODULE_NAMES="8812au(net/wireless:)"
BUILD_TARGETS="clean modules"
