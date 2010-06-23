# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="A voip pentest tools suite"
HOMEPAGE="http://code.google.com/p/sipvicious/"
SRC_URI="http://sipvicious.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/python"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-gentoo.patch
}

src_install() {
	dodir /usr/lib/sipvicious
	dodoc Changelog  README THANKS TODO
	rm -f Changelog  README THANKS TODO
	cp -pPR * "${D}"usr/lib/sipvicious/ || die
	chown -R root:0 "${D}"
	for file in `ls sv*.py`; do
		dosym /usr/lib/sipvicious/${file} /usr/bin/${file}
	done
}
