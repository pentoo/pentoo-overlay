# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
