# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="a brute force program that works against pptp vpn endpoints"
HOMEPAGE="http://www.thc.org"
SRC_URI="http://packetstorm.codar.com.br/groups/thc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/openssl"

S="${WORKDIR}"/${P/thc/THC}

src_prepare() {
	sed -i "s|-O2|$CFLAGS|g" configure || die "sed failed"
}

src_install() {
	dobin src/$PN || die "install failed"
	dodoc README TODO
}
