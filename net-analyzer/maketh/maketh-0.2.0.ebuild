# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Ethernet packet injector and creator"
HOMEPAGE="http://simpp-kode.tuxfamily.org/maketh/index.html"
SRC_URI="http://simpp-kode.tuxfamily.org/maketh/archive/maketh-0.2.0.tar.gz"

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
