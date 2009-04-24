# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlinject/sqlinject-1.1.ebuild,v 1.1.1.1 2006/03/21 14:30:26 grimmlin Exp $

MY_P="SQLiX_v1.0"
DESCRIPTION="Python based fuzzer for multi protocols, and faultinject"
HOMEPAGE="http://sqlmap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/python"

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	dodoc doc/*
	rm -rf doc
	dodir /usr/lib/"${PN}"/
	cp -R * "${D}"/usr/lib/"${PN}"/
	dosym /usr/lib/"${PN}"/sqlmap.py /usr/sbin/sqlmap 
}
