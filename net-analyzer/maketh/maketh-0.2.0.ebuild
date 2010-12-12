# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Ethernet packet injector and creator"
HOMEPAGE="http://simpp-kode.tuxfamily.org/maketh/index.html"
SRC_URI="http://packetstorm.wowhacker.com/UNIX/scanners/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	DESTDIR="${D}" emake -j1 install || die "install failed"
	dodoc README NEWS ChangeLog INSTALL BUG
}
