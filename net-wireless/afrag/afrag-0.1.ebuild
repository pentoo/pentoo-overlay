# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Implementation of a WIFI Fragmentation attack"
HOMEPAGE="http://homepages.tu-darmstadt.de/~p_larbig/wlan/"
SRC_URI="http://homepages.tu-darmstadt.de/~p_larbig/wlan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

src_compile() {
	gcc $CFLAGS -o ${PN} ${PN}.c
}

src_install() {
	dobin ${PN} || die "install failed"
	dodoc README
}
