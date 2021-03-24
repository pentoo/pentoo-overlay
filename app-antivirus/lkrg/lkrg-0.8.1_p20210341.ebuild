# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod linux-info

DESCRIPTION="Linux Kernel Runtime Guard"
HOMEPAGE="https://www.openwall.com/lkrg/"
HASH_COMMIT="b9ff71131d2816abdb882ec90b7edc86a0889e8b"
SRC_URI="https://github.com/openwall/lkrg/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
#SRC_URI="https://www.openwall.com/lkrg/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

MODULE_NAMES="p_lkrg(misc:${S}:${S})"
BUILD_TARGETS="clean all"
CONFIG_CHECK="JUMP_LABEL"


pkg_setup() {
	linux-mod_pkg_setup
	#compile against selected (not running) target
	BUILD_PARAMS="P_KVER=${KV_FULL} P_KERNEL=${KERNEL_DIR}"
}

pkg_postinst() {
	einfo "\nUsage:"
	einfo "\n    ~$ modprobe p_lkrg p_init_log_level=3\n"
}
