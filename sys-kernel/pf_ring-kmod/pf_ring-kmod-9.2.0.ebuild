# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

MY_P="PF_RING-${PV}"

DESCRIPTION="High-speed packet processing framework (kernel modules for)"
HOMEPAGE="http://www.ntop.org/products/packet-capture/pf_ring/"
SRC_URI="https://github.com/ntop/PF_RING/archive/${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}/kernel"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

CONFIG_CHECK="NET"
ERROR_NET="PF_RING requires CONFIG_NET=y set in the kernel."

#pkg_setup() {
#	linux-mod-r1_pkg_setup
#}

src_prepare() {
	#https://github.com/ntop/PF_RING/issues/709
#	eapply -p2 "${FILESDIR}/710.patch"\
	eapply -p2 "${FILESDIR}"/f6e8cb42a891ab3cf1eb2ecb52ae38a2af1096eb.patch
	eapply_user
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

pkg_postinst() {
	linux-mod-r1_pkg_postinst
}
