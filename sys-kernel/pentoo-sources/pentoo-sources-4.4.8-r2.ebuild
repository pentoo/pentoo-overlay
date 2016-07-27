# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="9"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-2"
HGPV_URI="http://dev.gentoo.org/~blueness/hardened-sources/hardened-patches/hardened-patches-${HGPV}.extras.tar.bz2"
PENPATCHES_VER="2"
PENPATCHES="penpatches-${PV}-${PENPATCHES_VER}.tar.xz"
PENPATCHES_URI="http://dev.pentoo.ch/~zero/distfiles/${PENPATCHES}"
SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI}"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2 ${DISTDIR}/${PENPATCHES}"

DESCRIPTION="Pentoo kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="https://github.com/pentoo/pentoo-livecd/tree/master/kernel/${PV}"
#IUSE="aufs deblob injection openfile_log pax_kernel"
IUSE="aufs deblob injection pax_kernel"

KEYWORDS="amd64 x86"

DEPEND=">=sys-devel/gcc-4.5"
PDEPEND="=sys-apps/gradm-3.1*"

pkg_setup() {
	# We are proud of it, let's show it
	UNIPATCH_EXCLUDE="4421_grsec-remove-localversion-grsec.patch"
	if ! use pax_kernel; then
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
		4427_force_XATTR_PAX_tmpfs.patch \
		4440_selinux-avc_audit-log-curr_ip.patch \
		4475_emutramp_default_on.patch \
		44??-grsec* \
		44??_grsec* \
		4445_disable-compat_vdso.patch \
		4420_grsecurity-* \
		4465_selinux-avc_audit-log-curr_ip.patch \
		4470_disable-compat_vdso.patch \
		4508_aufs4-mmap-pax.patch \
		4511_pax-4.4.2.patch"
	else
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
				1500_XATTR_USER_PREFIX.patch \
				2900_dev-root-proc-mount-fix.patch \
				4508_aufs4-mmap.patch \
				4400_logo_larry_the_cow.patch"
	fi
	if ! use aufs ; then
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
			4506_aufs4-kbuild.patch \
			4507_aufs4-base.patch \
			4508_aufs4-mmap.patch \
			4508_aufs4-mmap-pax.patch \
			4509_aufs4-standalone.patch \
			4510_aufs4-files.patch \
			4511_pax-4.4.2.patch"
	fi
	if ! use injection ; then
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} \
			4002_mac80211-2.6.29-fix-tx-ctl-no-ack-retry-count.patch \
			4004_zd1211rw-inject+dbi-fix-4.4ish.patch \
			4005_ipw2200-inject.3.4.6.patch"
	fi
	#use openfile_log && UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/openfile_log-36.patch"
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4500-new-dect-stack.patch"
}

pkg_postinst() {
	kernel-2_pkg_postinst

	ewarn "It may be desired to download the official pentoo kernel config from here:"
	if use amd64; then
		if use pax_kernel; then
			ewarn "https://github.com/pentoo/pentoo-livecd/tree/master/livecd/amd64/kernel/config-${PV}"
		else
			ewarn "https://github.com/pentoo/pentoo-livecd/tree/master/livecd/amd64/kernel/config-${PV}-soft"
		fi
	fi
	if use x86; then
		if use pax_kernel; then
			ewarn "https://github.com/pentoo/pentoo-livecd/tree/master/livecd/x86/kernel/config-${PV}"
		else
			ewarn "https://github.com/pentoo/pentoo-livecd/tree/master/livecd/x86/kernel/config-${PV}-soft"
		fi
	fi
}
