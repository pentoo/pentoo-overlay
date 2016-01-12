# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""
RDEPEND=""
PDEPEND="sys-apps/elfix"

S="${WORKDIR}"

src_install() {
	dobin "${FILESDIR}"/magic-pax
}
