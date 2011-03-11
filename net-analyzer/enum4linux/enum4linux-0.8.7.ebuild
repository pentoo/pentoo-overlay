# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="a tool for enumerating information from Windows and Samba systems"
HOMEPAGE="http://labs.portcullis.co.uk/application/enum4linux/"
SRC_URI="http://labs.portcullis.co.uk/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+polenum"

DEPEND=""
RDEPEND="dev-lang/perl
		net-fs/samba
		polenum? ( net-analyzer/polenum )"

src_install () {
	dobin enum4linux.pl || die "install failed"
	dosym /usr/bin/enum4linux.pl /usr/bin/enum4linux
	dodir /usr/share/enum4linux
	insinto /usr/share/enum4linux
	doins share-list.txt
	dodoc CHANGELOG
}
