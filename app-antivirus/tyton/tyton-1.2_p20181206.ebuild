# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod linux-info

HASH_COMMIT="c527bff7dfd958e2572d60b791615ea9e27ffe85"

DESCRIPTION="Kernel-Mode Rootkit Hunter"
HOMEPAGE="https://github.com/nbulischeck/tyton/"
SRC_URI="https://github.com/nbulischeck/tyton/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

#FIXME: add notify daemon:
#x11-libs/gtk+:3
#x11-libs/libnotify
#sys-apps/systemd

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

MODULE_NAMES="tyton(misc:${S}:${S})"
CONFIG_CHECK="NETFILTER_FAMILY_ARP"
BUILD_PARAMS="-j1"

pkg_setup() {
	linux-mod_pkg_setup
}
