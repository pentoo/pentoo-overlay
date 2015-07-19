# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_P="${PN}${PV/./}"

DESCRIPTION="A Web Content Scanner to look for existing/hidden content"
HOMEPAGE="http://dirb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	chmod u+x "${S}"/configure || die
}

src_install() {
	dobin dirb
	newbin gendict gendict_dirb
	dobin web2dic/html2dic
	insinto /usr/share/dict/dirb-wordlists
	doins -r wordlists/*

	dodoc README.txt docs/CHANGES.txt docs/GENDICT.TXT docs/TRICKS.txt
}
