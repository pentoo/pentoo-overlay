# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

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
	epatch "${FILESDIR}"/CVE-2006-0048.patch
	epatch "${FILESDIR}"/fix-double-free-error.patch
	epatch "${FILESDIR}"/fix-man-invocation.patch
	epatch "${FILESDIR}"/fix-build-with-gcc5.patch
	epatch "${FILESDIR}"/fix-infinite-loop-on-powerpc.patch
	epatch "${FILESDIR}"/fix-spelling-errors.patch
	epatch "${FILESDIR}"/set-timestamp-pcap-header-structure.patch
	eapply_user
}


src_install () {
	dobin src/tcpick
	dodoc EXAMPLES OPTIONS README
}
