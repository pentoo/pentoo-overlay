# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlinject/sqlinject-1.1.ebuild,v 1.1.1.1 2006/03/21 14:30:26 grimmlin Exp $

MY_P="SQLiX_v1.0"
DESCRIPTION="Python based fuzzer for multi protocols, and faultinject"
HOMEPAGE="http://cedri.cc/"
SRC_URI="http://cedri.cc/tools/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"/"${MY_P}"
DEPEND="dev-lang/perl
	dev-perl/WWW-CheckSite
	dev-perl/Tie-CharArray
	dev-perl/Algorithm-Diff"

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	insinto /usr/lib/"${PN}"/
	doins -r *
	dosbin "${FILESDIR}"/"${PN}"
}
