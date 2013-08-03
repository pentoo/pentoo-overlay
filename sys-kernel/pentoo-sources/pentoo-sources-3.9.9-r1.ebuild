# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="14"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version

PENPATCHES_VER="1"
PENPATCHES="penpatches-${PV}-${PENPATCHES_VER}.tar.xz"
PENPATCHES_URI="http://dev.pentoo.ch/~zero/distfiles/${PENPATCHES}"

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-1"
HGPV_URI="http://dev.gentoo.org/~blueness/hardened-sources/hardened-patches/hardened-patches-${HGPV}.extras.tar.bz2"
SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI}"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2 ${DISTDIR}/${PENPATCHES}"
UNIPATCH_EXCLUDE="
	1500_XATTR_USER_PREFIX.patch
	1510_af_key-fix-info-leaks-in-notify-messages.patch
	1511_ipv6-ip6_sk_dst_check-must-not-assume-ipv6-dst.patch
	2900_dev-root-proc-mount-fix.patch"

DESCRIPTION="Pentoo kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="http://www.pentoo.ch"
IUSE="aufs deblob injection openfile_log pax_kernel"

KEYWORDS="~amd64 ~x86"

PDEPEND="sys-kernel/linux-firmware
	>=sys-devel/gcc-4.5
	pax_kernel? ( >=sys-apps/gradm-2.9.1 )"

pkg_setup() {
	# We are proud of it, let's show it
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4421_grsec-remove-localversion-grsec.patch"
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
		9999_aufs3-grsec.patch"
	else
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4400_logo_larry_the_cow.patch"
	fi
	if ! use aufs ; then
	        UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
			4310_aufs3.patch \
			9999_aufs3-grsec.patch"
	fi
	if ! use injection ; then
		UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE}
			channel-negative-one-maxim.patch
			4002_mac80211-2.6.29-fix-tx-ctl-no-ack-retry-count.patch
			4004_zd1211rw-2.6.28.patch
			ipw2200-inject.3.4.6.patch"
	fi
	use openfile_log && UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/openfile_log-36.patch"
	#UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/9997-desktop-responsiveness_2.6.35_fix.patch"
	UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4500-new-dect-stack.patch"
}

pkg_postinst() {
	kernel-2_pkg_postinst

	ewarn
	ewarn "Hardened Gentoo provides three different predefined grsecurity level:"
	ewarn "[server], [workstation], and [virtualization].  Those who intend to"
	ewarn "use one of these predefined grsecurity levels should read the help"
	ewarn "associated with the level.  Because some options require >=gcc-4.5,"
	ewarn "users with more, than one version of gcc installed should use gcc-config"
	ewarn "to select a compatible version."
	ewarn
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	ewarn "It may be desired to download the official pentoo kernel config from here:"
	use x86 && ewarn "https://pentoo.googlecode.com/svn/livecd/trunk/x86/kernel/config-${PV}"
	use amd64 && ewarn "https://pentoo.googlecode.com/svn/livecd/trunk/amd64/kernel/config-${PV}"
}
