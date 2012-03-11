# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit toolchain-funcs eutils

DESCRIPTION="SIPcrack is a SIP protocol login cracker"
HOMEPAGE="http://www.remote-exploit.org/?page_id=418 -gone"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~arm"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's|${FLAGS}|${CFLAGS} ${LDFLAGS}|g' Makefile
}

src_compile() {
	emake -e CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin sipcrack sipdump
	dodoc README USAGE_EXAMPLES
}
