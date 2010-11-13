# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Crunch is a wordlist generator"
HOMEPAGE="http://sourceforge.net/projects/crunch-wordlist/"
SRC_URI="mirror://sourceforge/crunch-wordlist/crunch-wordlist/${PN}${PV}.tgz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}${PV}"

src_install(){
	dobin crunch || die
	doman crunch.1
	insinto /usr/share/crunch
	doins charset.lst || die
}
