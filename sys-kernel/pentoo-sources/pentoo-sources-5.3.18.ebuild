# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="21"

inherit kernel-2
detect_version
detect_arch

#nvidia doesn't have a release for x86 that supports >4.17 yet, so now we give up on them
KEYWORDS="amd64 x86"
HOMEPAGE="https://github.com/pentoo/pentoo-livecd/tree/master/kernel/"
IUSE="experimental pax_kernel pentoo-experimental"

DESCRIPTION="Pentoo kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"

#normal penpatches
PENPATCHES_VER="1"
PENPATCHES="penpatches-5.3.8-${PENPATCHES_VER}.tar.xz"
PENPATCHES_URI="https://dev.pentoo.ch/~zero/distfiles/${PENPATCHES}"
#experimental penpatches
PENPATCHES_EXP_VER="2"
PENPATCHES_EXP="penpatches-experimental-5.3.8-${PENPATCHES_EXP_VER}.tar.xz"
PENPATCHES_EXP_URI="https://dev.pentoo.ch/~zero/distfiles/${PENPATCHES_EXP}"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI} ${PENPATCHES_EXP_URI}"

UNIPATCH_LIST="${DISTDIR}/${PENPATCHES}"

pkg_setup() {
	if use pax_kernel; then
		die "pax_kernel is no longer available, you MUST ensure the use flag is no longer set"
	fi
}

src_unpack() {
	use pentoo-experimental && UNIPATCH_LIST+=" ${DISTDIR}/${PENPATCHES_EXP}"
	kernel-2_src_unpack
}
pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"

	ewarn "It may be desired to download the official pentoo kernel config from here:"
	if use amd64; then
		ewarn "https://raw.githubusercontent.com/pentoo/pentoo-livecd/master/livecd/amd64/kernel/config-${PV}"
	fi
	if use x86; then
		ewarn "https://raw.githubusercontent.com/pentoo/pentoo-livecd/master/livecd/x86/kernel/config-${PV}"
	fi
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
