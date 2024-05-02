# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Attempt at applying pax marks effectively"
HOMEPAGE="https://none.com"

S="${WORKDIR}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"

PDEPEND="sys-apps/elfix"

src_install() {
	dobin "${FILESDIR}"/magic-pax
}
