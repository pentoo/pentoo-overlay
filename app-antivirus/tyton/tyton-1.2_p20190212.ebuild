# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod linux-info

HASH_COMMIT="bf144b46b89df9ca60d440bf1f8e472efa017fec"

DESCRIPTION="Kernel-Mode Rootkit Hunter"
HOMEPAGE="https://github.com/nbulischeck/tyton/"
SRC_URI="https://github.com/nbulischeck/tyton/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"

#https://github.com/nbulischeck/tyton/issues/19
#KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

MODULE_NAMES="tyton(misc:${S}:${S})"
CONFIG_CHECK="NETFILTER_FAMILY_ARP"
BUILD_PARAMS="-j1"

pkg_setup() {
	linux-mod_pkg_setup
}
