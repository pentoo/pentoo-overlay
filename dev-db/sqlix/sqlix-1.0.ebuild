# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlinject/sqlinject-1.1.ebuild,v 1.1.1.1 2006/03/21 14:30:26 grimmlin Exp $

MY_P="SQLiX_v1.0"
DESCRIPTION="Perl based fuzzer for multi protocols, and faultinject"
HOMEPAGE="http://cedri.cc/"
SRC_URI="http://dev.pentoo.ch/~jensp/distfiles/${MY_P}.tar.gz" # mirrored, upstream dead

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/WWW-CheckSite
	dev-perl/Tie-CharArray
	dev-perl/Algorithm-Diff"

RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${MY_P}"

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	insinto /usr/lib/"${PN}"/
	doins -r *
	dosbin "${FILESDIR}"/"${PN}"
}
