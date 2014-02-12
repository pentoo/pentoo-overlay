# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT="python2_7"
inherit eutils python-single-r1

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
	dodir /usr/share/${PN}
	dodoc Changelog  README.md THANKS TODO
	rm -f Changelog  README.md THANKS TODO
	chmod 655 svcrash.py
	cp -pPR * "${ED}"usr/share/${PN}/ || die
	chown -R root:0 "${ED}"
	for file in svmap.py svwar.py svcrack.py svreport.py svcrash.py; do
		dosym /usr/share/${PN}/${file} /usr/bin/${file%%.*}
	done
	python_fix_shebang "${ED}"usr/share/${PN}
}
