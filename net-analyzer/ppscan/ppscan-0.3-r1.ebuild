# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Port scanner with HTTP and FTP tunneling support"
HOMEPAGE="https://packetstormsecurity.com/files/82897/PPScan-Portscanner-0.3.html"
SRC_URI="https://dl.packetstormsecurity.net/UNIX/scanners/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	$(tc-getCC) -o ppscan ppscan.c -lpthread ${CFLAGS} ${LDFLAGS} || die "failed to compile"
}

src_install() {
	dobin ppscan
	dodoc README
}
