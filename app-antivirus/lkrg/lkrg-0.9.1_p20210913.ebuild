# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod linux-info

DESCRIPTION="Linux Kernel Runtime Guard"
HOMEPAGE="https://www.openwall.com/lkrg/"
HASH_COMMIT="dd7fcec11f11efe0ae2fc6b8aa7b32880484a48b"
SRC_URI="https://github.com/openwall/lkrg/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
#SRC_URI="https://www.openwall.com/lkrg/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
MODULE_NAMES="p_lkrg(misc:${S}:${S})"

pkg_setup() {
	local CONFIG_CHECK="JUMP_LABEL"
	linux-mod_pkg_setup

	# compile against selected (not running) target
	BUILD_PARAMS="P_KVER=${KV_FULL} P_KERNEL=${KERNEL_DIR}"
	BUILD_TARGETS="all"
}

pkg_postinst() {
	einfo "Usage:"
	einfo "modprobe p_lkrg p_init_log_level=3"
}
