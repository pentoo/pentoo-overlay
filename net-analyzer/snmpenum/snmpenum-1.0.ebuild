# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/snmpenum/snmpenum-1.0.ebuild,v 1.1.1.1 2006/03/30 21:16:49 grimmlin Exp $

EAPI=2

inherit eutils

DESCRIPTION="A perl script to enumerate SNMP table dumper"
HOMEPAGE="http://packetstormsecurity.org"
SRC_URI="http://packetstorm.wowhacker.com/UNIX/scanners/${PN}.zip"

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

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	dodoc *.txt
	newsbin ${PN}.pl ${PN}
}
