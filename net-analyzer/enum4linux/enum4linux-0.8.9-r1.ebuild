# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="a tool for enumerating information from Windows and Samba systems"
HOMEPAGE="http://labs.portcullis.co.uk/application/enum4linux/"
SRC_URI="http://labs.portcullis.co.uk/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+polenum ldap"

DEPEND=""
RDEPEND="dev-lang/perl
		net-fs/samba
		polenum? ( net-analyzer/polenum )
		ldap? ( net-nds/openldap )"

src_prepare () {
	sed -i -e 's/polenum.py/polenum/' ${PN}.pl || die "Sed failed!"
}

src_install () {
	newbin ${PN}.pl ${PN}
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins share-list.txt
	dodoc CHANGELOG
}
