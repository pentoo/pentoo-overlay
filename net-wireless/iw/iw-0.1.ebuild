# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

DESCRIPTION="Extra tool for use with aircrack-ng"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI="http://dl.aircrack-ng.org/${PN}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND=">=dev-libs/libnl-1.1"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}/usr"
}
