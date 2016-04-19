# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="A perl script to enumerate SNMP table dumper"
HOMEPAGE="http://packetstormsecurity.org"
SRC_URI="https://dl.packetstormsecurity.net/UNIX/scanners/${PN}.zip"
RESTRICT="fetch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Net-SNMP"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Upstream's certificate chain is incomplete. Run the following command:"
	einfo "wget \"${SRC_URI}\" --no-check-certificate"
	einfo "and placed the file into ${DISTDIR}"
}

src_configure() {
	epatch "${FILESDIR}"/${PN}-gentoo.patch
}

src_install() {
	dodoc *.txt
	newsbin ${PN}.pl ${PN}
}
