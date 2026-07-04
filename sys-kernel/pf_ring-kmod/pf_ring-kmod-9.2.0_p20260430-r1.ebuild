# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

MY_PN="PF_RING"	# upstream calls it this way
MY_P="${MY_PN}-${PV}"
COMMIT_HASH="53d901fbf55e8a1df156a4511a992703c141411c" # HEAD of 9.2.0-stable, last commit 2026-04-30

DESCRIPTION="PF_RING: High-speed packet processing framework (kernel modules for)"
HOMEPAGE="https://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI="https://github.com/ntop/${MY_PN}/archive/${COMMIT_HASH}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT_HASH}/kernel"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

CONFIG_CHECK="NET"
ERROR_NET="${MY_PN} requires CONFIG_NET=y set in the kernel."

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_compile() {
	local modargs=( M="${S}" EXTRA_CFLAGS="-I${S}" BUILD_KERNEL="${KV_FULL}" )
	local modlist=( pf_ring=net/pf_ring:"${S}":"${S}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /usr/include/linux
	doins linux/pf_ring.h || die
}
