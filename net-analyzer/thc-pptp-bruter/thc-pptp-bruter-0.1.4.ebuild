# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="a brute force program that works against pptp vpn endpoints"
HOMEPAGE="http://www.thc.org"
SRC_URI="https://www.thc.org/download.php?t=r&f=${P}.tar.gz -> ${P}.tar.gz"

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
	dobin src/$PN
	dodoc README TODO
}
