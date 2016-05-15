# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="A perl script to enumerate SNMP table dumper"
HOMEPAGE="http://packetstormsecurity.org"
SRC_URI="https://dl.packetstormsecurity.net/UNIX/scanners/${PN}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Net-SNMP"

S="${WORKDIR}"

src_configure() {
	epatch "${FILESDIR}"/${PN}-gentoo.patch
}

src_install() {
	dodoc *.txt
	newsbin ${PN}.pl ${PN}
}
