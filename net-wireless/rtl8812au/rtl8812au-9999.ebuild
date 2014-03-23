# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 linux-info

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/abperiasamy/rtl8812AU_8821AU_linux.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	set_arch_to_kernel
	KSRC="${KV_DIR}" KVER="${KV_FULL}" emake
}

src_install() {
	insinto "/lib/modules/${KV_FULL}/kernel/drivers/net/wireless/"
	doins 8812au.ko
	#emake MODDESTDIR="${ED}/lib/modules/${KV_FULL}/kernel/drivers/net/wireless/" install
}
