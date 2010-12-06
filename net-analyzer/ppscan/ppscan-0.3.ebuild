# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="port scanner with HTTP and FTP tunneling support"
HOMEPAGE="http://aconole.brad-x.com/programs/"
SRC_URI="http://packetstorm.wowhacker.com/UNIX/scanners/ppscan-0.3.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	gcc -o ppscan ppscan.c -lpthread $CFLAGS || die "failed to compile"
}

src_install() {
	dobin ppscan
	dodoc README
	prepall
}
