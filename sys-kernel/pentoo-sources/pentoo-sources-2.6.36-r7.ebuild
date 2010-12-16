# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="7"
PENPATCHES_VER="2"
inherit kernel-2
detect_version
detect_arch
K_SECURITY_UNSUPPORTED="1"

KEYWORDS="~x86 ~amd64"
HOMEPAGE="http://dev.pentoo.ch/~jensp/penpatches.xhtml"
IUSE="openfile_log +grsec"
DESCRIPTION="Full sources including the Pentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

PENPATCHES="penpatches-${PV}-${PENPATCHES_VER}.tar.bz2"
PENPATCHES_URI="http://dev.pentoo.ch/~jensp/distfiles/${PENPATCHES}"

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-7"
HGPV_URI="mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"

UNIPATCH_LIST="${DISTDIR}/${PENPATCHES} ${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI} ${HGPV_URI}"

pkg_setup() {
	# We are proud of it, let's show it
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4421_grsec-remove-localversion-grsec.patch"
	if ! use grsec; then
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
4440_selinux-avc_audit-log-curr_ip.patch \
4423_grsec-remove-protected-paths.patch \
4435_grsec-kconfig-gentoo.patch \
4425_grsec-pax-without-grsec.patch \
4445_disable-compat_vdso.patch \
4430_grsec-kconfig-default-gids.patch \
4422_grsec-mute-warnings.patch
4420_grsecurity-*"
fi
#this is what happens when I get yelled at, now I don't have to update the 4420
#exclustion each time :-)
	use openfile_log && UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/openfile_log.patch"
	#UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/9997-desktop-responsiveness_2.6.35_fix.patch"
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
