# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="10"
PENPATCHES_VER="1"
inherit kernel-2
detect_version
detect_arch
K_SECURITY_UNSUPPORTED="1"

KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://dev.pentoo.ch/~jensp/penpatches.xhtml"
IUSE="openfile_log +aufs"
DESCRIPTION="Full sources including the Pentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

PENPATCHES="penpatches-${PV}-${PENPATCHES_VER}.tar.xz"
PENPATCHES_URI="http://dev.pentoo.ch/~grimmlin/distfiles/${PENPATCHES}"

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-6"
HGPV_URI="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"

UNIPATCH_LIST="${DISTDIR}/${PENPATCHES}"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI}"

pkg_setup() {
	if ! use aufs ; then
	        UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
			4310_aufs3.patch"
	fi

	use openfile_log && UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/openfile_log-36.patch"
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4500-new-dect-stack.patch"
}


pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	eerror "It may be desired to download the official pentoo kernel config from here:"
	use x86 && eerror "https://www.pentoo.ch/svn/livecd/trunk/x86/kernel/config-${PV}"
	use amd64 && eerror "https://www.pentoo.ch/svn/livecd/trunk/amd64/kernel/config-${PV}"
	if ! version_is_at_least 4.4.3 "$(gcc-fullversion)"; then
		ewarn "If you are using the pentoo kernel config then you must also install"
		ewarn "and use >=sys-devel/gcc-4.4.3 to build"
		epause 3
	fi
}
