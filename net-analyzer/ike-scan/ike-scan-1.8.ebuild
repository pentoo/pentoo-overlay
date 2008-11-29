# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/ike-scan/ike-scan-1.8.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

DESCRIPTION="A utility for finding, fingerprinting and testing IKE VPN servers"
HOMEPAGE="http://www.nta-monitor.com/ike-scan/"
SRC_URI="http://www.nta-monitor.com/ike-scan/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="openssl"

DEPEND="virtual/libc
	openssl? dev-libs/openssl"

src_compile() {
	use openssl && conf="--with-openssl"
	econf ${conf} || die
	emake || die
}

src_install() {
	einstall install || die
	dodoc ChangeLog NEWS INSTALL README TODO
}
