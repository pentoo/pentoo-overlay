# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Ethernet packet injector and creator"
HOMEPAGE="http://simpp-kode.tuxfamily.org/maketh/index.html"
SRC_URI="https://dl.packetstormsecurity.net/UNIX/scanners/${P}.tar.gz"

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
