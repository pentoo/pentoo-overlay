# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Port scanner with HTTP and FTP tunneling support"
HOMEPAGE="https://packetstormsecurity.com/files/82897/PPScan-Portscanner-0.3.html"
SRC_URI="https://dl.packetstormsecurity.net/UNIX/scanners/ppscan-0.3.tar.gz"

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
