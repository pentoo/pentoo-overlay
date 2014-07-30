# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="tests WebDAV enabled servers"
HOMEPAGE="http://code.google.com/p/davtest/"
SRC_URI="http://davtest.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="virtual/perl-Getopt-Long
	dev-perl/HTTP-DAV"

src_install() {
	dobin davtest.pl || die
	insinto /usr/share/${PN}/
	doins -r tests || die
	doins -r backdoors  || die
	dodoc README.txt || die
}
