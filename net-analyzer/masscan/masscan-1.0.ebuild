# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Mass IP port scanner"
HOMEPAGE="https://github.com/robertdavidgraham/masscan"
SRC_URI="https://github.com/robertdavidgraham/masscan/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}"

src_prepare(){
	sed -e 's|$(CC) $(CFLAGS)|$(CC) $(LDFLAGS) $(CFLAGS)|g' -i Makefile || die "sed failed"
}

src_install() {
	dobin bin/masscan

	insinto /etc/masscan
	doins data/exclude.conf
	doins "${FILESDIR}"/masscan.conf

	dohtml doc/bot.hml
	doman doc/masscan.8
	dodoc README.md
}
