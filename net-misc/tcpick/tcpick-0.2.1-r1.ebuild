# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="A tcp stream sniffer, tracker and capturer."
HOMEPAGE="http://tcpick.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/tcpick-0.2.1-CVE-2006-0048.patch
	epatch "${FILESDIR}"/tcpick-0.2.1-ppc.patch
	epatch "${FILESDIR}"/tcpick-0.2.1-cpu-loop.patch
	epatch "${FILESDIR}"/tcpick-0.2.1-timezone.patch
	epatch "${FILESDIR}"/tcpick-0.2.1-pointers.patch
	epatch "${FILESDIR}"/tcpick_0.2.1-shortpkts.patch
}

src_install () {
	dobin src/tcpick
	dodoc EXAMPLES OPTIONS README
}
