# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="This little tools is designed to get geolocalization information of a host"
HOMEPAGE="http://www.edge-security.com/edge-soft.php"
SRC_URI="http://www.edge-security.com/soft/${PN}.py"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""
SLOT="0"

src_unpack() {
	elog "Nothing to unpack"
	mkdir "${S}"
	cp "${DISTDIR}"/"${A}" "${S}"
}

src_compile() {
	elog "Nothing to compile"
}

src_install() {
	dobin "${PN}".py
}
