# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="exploiting cisco leap; As in asleap behind the wheel."
HOMEPAGE="http://www.willhackforsushi.com/Asleap.html"
SRC_URI="http://www.willhackforsushi.com/code/asleap/2.2/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm"
IUSE=""
RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}"

src_install() {
	dosbin asleap
	dobin genkeys
	dodoc THANKS README || die
}
