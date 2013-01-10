# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-3.4.2.ebuild,v 1.2 2012/06/29 00:11:38 blueness Exp $

EAPI="5"

ETYPE="sources"
# K_WANT_GENPATCHES="base extras"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="1"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version

PENPATCHES_VER="1"
# PENPATCHES="penpatches-${PV}-${PENPATCHES_VER}.tar.xz"
PENPATCHES="penpatches-3.5.4-${PENPATCHES_VER}.tar.xz"
PENPATCHES_URI="http://dev.pentoo.ch/~zero/distfiles/${PENPATCHES}"

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-1"
HGPV_URI="http://dev.gentoo.org/~blueness/hardened-sources/hardened-patches/hardened-patches-${HGPV}.extras.tar.bz2"
SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI}"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2 ${DISTDIR}/${PENPATCHES}"
UNIPATCH_EXCLUDE="4200_fbcondecor-0.9.6.patch"

DESCRIPTION="Hardened kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"
IUSE="aufs deblob openfile_log pax_kernel"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"

RDEPEND=">=sys-devel/gcc-4.5
	pax_kernel? ( >=sys-apps/gradm-2.9.1 )"

pkg_setup() {
	# We are proud of it, let's show it
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4421_grsec-remove-localversion-grsec.patch"
	if ! use pax_kernel; then
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
		4440_selinux-avc_audit-log-curr_ip.patch \
		44??-grsec*
		44??_grsec*
		4445_disable-compat_vdso.patch \
		4420_grsecurity-*
		4465_selinux-avc_audit-log-curr_ip.patch
		4470_disable-compat_vdso.patch
		9999_aufs3-grsec.patch"
	else
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4400_logo_larry_the_cow.patch"
	fi
	if ! use aufs ; then
	        UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
			4310_aufs3.patch \
			9999_aufs3-grsec.patch"
	fi

	use openfile_log && UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/openfile_log-36.patch"
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4500-new-dect-stack.patch"

	use pax_kernel && UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/${P}-fhash.patch"
}

pkg_postinst() {
	kernel-2_pkg_postinst

	local GRADM_COMPAT="sys-apps/gradm-2.9.1"

	ewarn
	ewarn "Hardened Gentoo provides three different predefined grsecurity level:"
	ewarn "[server], [workstation], and [virtualization].  Those who intend to"
	ewarn "use one of these predefined grsecurity levels should read the help"
	ewarn "associated with the level.  Because some options require >=gcc-4.5,"
	ewarn "users with more, than one version of gcc installed should use gcc-config"
	ewarn "to select a compatible version."
	ewarn
	ewarn "Users of grsecurity's RBAC system must ensure they are using"
	ewarn "${GRADM_COMPAT}, which is compatible with ${PF}."
	ewarn "It is strongly recommended that the following command is issued"
	ewarn "prior to booting a ${PF} kernel for the first time:"
	ewarn
	ewarn "emerge -na =${GRADM_COMPAT}*"
	ewarn
	ewarn
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	ewarn "It may be desired to download the official pentoo kernel config from here:"
	use x86 && ewarn "https://pentoo.googlecode.com/svn/livecd/trunk/x86/kernel/config-${PV}"
	use amd64 && ewarn "https://pentoo.googlecode.com/svn/livecd/trunk/amd64/kernel/config-${PV}"
}
