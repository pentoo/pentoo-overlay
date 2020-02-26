# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

ETYPE="sources"
K_WANT_GENPATCHES="base"
#K_GENPATCHES_VER="76"
#K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version

HGPV="20180103130648"
HGPV_URI="https://github.com/minipli/linux-unofficial_grsec/releases/download/v${PV}-unofficial_grsec/v${PV}-unofficial_grsec-${HGPV}.diff"

OLD_GENPATCHES_URI="https://dev.gentoo.org/~mpagano/genpatches/tarballs/genpatches-4.9-76.base.tar.xz"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${OLD_GENPATCHES_URI} ${ARCH_URI}"

UNIPATCH_LIST="${DISTDIR}/v${PV}-unofficial_grsec-${HGPV}.diff"
UNIPATCH_EXCLUDE="
	1500_XATTR_USER_PREFIX.patch
	1520_CVE-2017-6074-dccp-skb-freeing-fix.patch
	2900_dev-root-proc-mount-fix.patch"

DESCRIPTION="Unofficial forward ports of the last publicly available grsecurity patch"
HOMEPAGE="https://github.com/minipli/linux-unofficial_grsec"
IUSE="deblob injection"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=sys-devel/gcc-4.5"

src_prepare(){
	#apply hardened-adapted patch
	#section: b/net/mac80211/cfg.c
	use injection && epatch "${FILESDIR}/grsec-wifi-injection-4.9.patch"
	eapply_user
}

pkg_postinst() {
	kernel-2_pkg_postinst

	local GRADM_COMPAT="sys-apps/gradm-3.1*"

	ewarn
	ewarn "Users of grsecurity's RBAC system must ensure they are using"
	ewarn "${GRADM_COMPAT}, which is compatible with ${PF}."
	ewarn "It is strongly recommended that the following command is issued"
	ewarn "prior to booting a ${PF} kernel for the first time:"
	ewarn
	ewarn "emerge -na =${GRADM_COMPAT}"
	ewarn
}
