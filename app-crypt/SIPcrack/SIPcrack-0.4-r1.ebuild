# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs eutils

DESCRIPTION="SIPcrack is a SIP protocol login cracker"
HOMEPAGE="http://www.remote-exploit.org/?page_id=418"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e 's|${FLAGS}|${CFLAGS} ${LDFLAGS}|g' \
		-e 's|strip sipcrack sipdump||' \
		Makefile || die

	default
}

src_compile() {
	emake -e CC="$(tc-getCC)"
}

src_install() {
	dobin sipcrack sipdump
	dodoc README USAGE_EXAMPLES
}
