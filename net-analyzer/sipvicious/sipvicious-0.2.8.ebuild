# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="A voip pentest tools suite"
HOMEPAGE="http://code.google.com/p/sipvicious/"
SRC_URI="http://sipvicious.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="pdf"

DEPEND=""
RDEPEND="pdf? ( dev-python/reportlab )"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-path.patch
	find ./ -name .svn | xargs rm -r
}

src_install() {
	dodir /usr/share/sipvicious
	dodoc Changelog  README.md THANKS TODO
	rm -f Changelog  README.md THANKS TODO
	chmod 655 svcrash.py
	cp -pPR * "${D}"usr/share/sipvicious/ || die
	chown -R root:0 "${D}"
	for file in svmap.py svwar.py svcrack.py svreport.py svcrash.py; do
		dosym /usr/share/sipvicious/${file} /usr/bin/${file}
	done
}
