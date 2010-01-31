# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Make a hexdump or do the reverse"
HOMEPAGE="http://ftp.uni-erlangen.de/pub/utilities/etc/?order=s"
SRC_URI="http://ftp.uni-erlangen.de/pub/utilities/etc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="!app-editors/vim"

src_prepare () {
	sed -i "s|-O|$CFLAGS|g" Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin xxd
	doman xxd.1
}
