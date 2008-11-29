# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils

DESCRIPTION="SIPcrack is a SIP protocol login cracker"
HOMEPAGE="http://www.remote-exploit.org/codes_sipcrack.html"
SRC_URI="http://www.remote-exploit.org/codes/sipcrack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-libs/libpcap"

src_compile() {
	emake -e CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin sipcrack sipdump
	dodoc README USAGE_EXAMPLES
}
