# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="a distributed password cracker"
HOMEPAGE="http://btb.banquise.net/"
#SRC_URI="http://btb.banquise.net/bin/$P.tar.gz"
SRC_URI="http://download.openwall.net/pub/projects/john/contrib/parallel/btb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse2"

DEPEND="$RDEPEND"
RDEPEND="dev-libs/libevent"

src_configure() {
	#TODO configure is pretty fscked up, it doesn't seem to respect CFLAGS and
	# ignores our settings
	local myconf

	if use sse2; then
		myconf="--enable-sse2"
	else
		myconf="--disable-sse2"
	fi
	econf ${myconf}
}

src_compile() {
	CFLAGS="$CFLAGS" emake
}

src_install() {
	DESTDIR="${D}" emake install
	dodoc README NEWS TODO
}
