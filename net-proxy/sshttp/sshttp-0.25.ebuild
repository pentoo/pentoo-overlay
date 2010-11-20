# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="an easy to use OSI-Layer5 switching daemon"
HOMEPAGE="http://c-skills.blogspot.com/"
SRC_URI="http://stealth.openwall.net/networking/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i "s|-O2|$CFLAGS|g" Makefile || die
}

src_install() {
	dobin sshttpd || die
	dodoc README || die
	dobin nf-setup || die
}
