# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/snmpenum/snmpenum-1.0.ebuild,v 1.1.1.1 2006/03/30 21:16:49 grimmlin Exp $

inherit eutils

DESCRIPTION="A perl script to enumerate SNMP table dumper"
HOMEPAGE="http://packetstormsecurity.org"
SRC_URI="http://packetstormsecurity.org/UNIX/scanners/${PN}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""
S=${WORKDIR}

src_compile () {
	einfo "Nothing to compile"
	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_install () {
	dodoc *.txt
	newsbin ${PN}.pl ${PN}
}
