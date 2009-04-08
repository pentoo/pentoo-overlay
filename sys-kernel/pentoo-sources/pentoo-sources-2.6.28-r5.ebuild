# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="7"
PENPATCHES_VER="5"
inherit kernel-2
detect_version
detect_arch
K_SECURITY_UNSUPPORTED="1"

KEYWORDS="amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
HOMEPAGE="http://dev.pentoo.ch/~grimmlin/penpatches"

DESCRIPTION="Full sources including the Pentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

PENPATCHES="penpatches-${PV}-${PENPATCHES_VER}.tar.bz2"
PENPATCHES_URI="http://dev.pentoo.ch/~grimmlin/penpatches/${PENPATCHES}"

UNIPATCH_LIST="${DISTDIR}/${PENPATCHES}"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI}"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
