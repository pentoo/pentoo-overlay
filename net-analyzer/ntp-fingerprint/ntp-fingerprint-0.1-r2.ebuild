# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="NTP fingerprinting utility"
HOMEPAGE="http://www.arhont.com/en/category/resources/tools-utilities/"
SRC_URI="http://www.arhont.com/en/wp-content/uploads/2010/01/ntp-fingerprint.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}

src_install() {
	newbin "${PN}".pl "${PN}"
	dodoc README.txt
}
