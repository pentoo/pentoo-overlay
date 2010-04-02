# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"


ETYPE="sources"
K_WANT_GENPATCHES="extras"
K_GENPATCHES_VER="7"
PENPATCHES_VER="5"

inherit kernel-2

detect_version
detect_arch
K_SECURITY_UNSUPPORTED="1"

PENPATCHES="penpatches-${PV}-${PENPATCHES_VER}.tar.bz2"
PENPATCHES_URI="http://dev.pentoo.ch/~grimmlin/penpatches/${PENPATCHES}"
KERNEL_URI="http://chaox.net/~jens/linux-2.6.28.tar.bz2"

DESCRIPTION="Full sources including the Pentoo patchset and Nokia N900 patches for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://dev.pentoo.ch/~grimmlin/penpatches http://maemo.org"
SRC_URI="${PENPATCHES_URI} ${GENPATCHES_URI} ${KERNEL_URI}"
UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/${PENPATCHES}"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
