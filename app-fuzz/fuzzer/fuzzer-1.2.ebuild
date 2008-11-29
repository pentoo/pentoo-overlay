# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/fuzzer/fuzzer-1.2.ebuild,v 1.1.1.1 2006/03/12 23:52:44 grimmlin Exp $

DESCRIPTION="Python based fuzzer for multi protocols, and faultinject"
HOMEPAGE="http://www.whitehat.co.il/shadown/freetools.html"
SRC_URI="http://www.whitehat.co.il/shadown/freetools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/pyopenssl"

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	dodoc README TODO
	insinto /opt/"${PN}"/
	insopts -m0755
	doins *.py
	dosbin "${FILESDIR}"/"${PN}"
}
