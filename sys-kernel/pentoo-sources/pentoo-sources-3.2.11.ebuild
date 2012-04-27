# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-3.2.11.ebuild,v 1.2 2012/04/19 22:13:17 blueness Exp $

EAPI="4"

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="11"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version

PENPATCHES_URI="http://dev.pentoo.ch/~zero/distfiles/penpatches-${PV}-1.tar.xz"

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-1"
HGPV_URI="http://dev.gentoo.org/~blueness/hardened-sources/hardened-patches/hardened-patches-${HGPV}.extras.tar.bz2"
SRC_URI="${PENPATCHES_URI} ${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="4200_fbcondecor-0.9.6.patch"
! use xtpax && UNIPATCH_EXCLUDE+=" 4425_grsec_enable_xtpax.patch"

DESCRIPTION="Hardened kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"
IUSE="aufs deblob openfile_log pax_kernel -xtpax"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"

RDEPEND=">=sys-devel/gcc-4.5
	 pax_kernel? ( >=sys-apps/gradm-2.9 )"

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
	#UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/9997-desktop-responsiveness_2.6.35_fix.patch"
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4500-new-dect-stack.patch"
}


pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	eerror "It may be desired to download the official pentoo kernel config from here:"
	use x86 && eerror "https://www.pentoo.ch/svn/livecd/trunk/x86/kernel/config-${PV}"
	use amd64 && eerror "https://www.pentoo.ch/svn/livecd/trunk/amd64/kernel/config-${PV}"
}
