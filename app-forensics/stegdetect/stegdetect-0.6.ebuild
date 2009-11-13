# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
NEED_AUTOMAKE="1.4"

inherit autotools eutils

DESCRIPTION="A Steganography detector for JPEG"
HOMEPAGE="http://www.outguess.org/"
SRC_URI="http://www.outguess.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="X"
RDEPEND="sys-apps/file
	dev-libs/glib:1
	X? ( x11-libs/gtk+:1 )"
DEPEND="${RDEPEND}"

src_compile(){
	epatch ${FILESDIR}/${P}.patch
	./configure
	emake || die "make failed"
}

src_install() {
	insinto /usr/share/stegbreak/
	doins rules.ini
	dobin stegbreak stegcompare stegdeimage stegdetect
	use X && dobin xsteg
	doman *.1
}
