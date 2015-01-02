# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit linux-mod linux-info eutils

MY_P="PF_RING-${PV}"

DESCRIPTION="A new type of network socket that improves packet capture speed."
HOMEPAGE="http://www.ntop.org/products/pf_ring/"
SRC_URI="mirror://sourceforge/ntop/PF_RING/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

MODULE_NAMES="pf_ring(net/pf_ring:${S}/kernel:${S}/kernel)"
CONFIG_CHECK="NET"
ERROR_NET="PF_RING-${PV} requires CONFIG_NET=y set in the kernel."
BUILD_TARGETS="modules"

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -ge 3 10 && die "kernel 3.10.0 or higher is not supported by this version"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S}/kernel EXTRA_CFLAGS='-I${S}/kernel'"
}

src_prepare() {
	epatch "${FILESDIR}"/pf_ring-kernel3_9.patch
}

src_install() {
	linux-mod_src_install
	insinto /usr/include/linux
	doins kernel/linux/pf_ring.h || die
	insinto /etc/modprobe.d
	doins "${FILESDIR}"/pf_ring.conf || die
	sed -i -e 's:DOCDIR:/usr/share/doc/'${PF}'/README.module_options:g' \
		"${D}etc/modprobe.d/pf_ring.conf" || die
	dodoc "${FILESDIR}"/README.module_options
}

pkg_postinst() {
	einfo "Please see /usr/share/doc/${PF}/README.module_options for configuration options"
	linux-mod_pkg_postinst
}
