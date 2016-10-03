# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 eutils

DESCRIPTION="Set of IPv6 security/trouble-shooting tools to send arbitrary IPv6-based packets"
HOMEPAGE="http://www.si6networks.com/tools/ipv6toolkit/"
EGIT_REPO_URI="https://github.com/fgont/ipv6toolkit.git"
EGIT_COMMIT="d14d90969e88a455e4ca8ea0ea7d88c9b7fb5c9f"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap[ipv6(+)]"
RDEPEND="${DEPEND}
	sys-apps/hwids"

src_compile() {
	emake CFLAGS="-Wall ${CFLAGS}" PREFIX=/usr
}

src_install() {
	dodir /etc
	emake install DESTDIR="${D}" PREFIX=/usr
	dodoc CHANGES.TXT README.TXT
}
