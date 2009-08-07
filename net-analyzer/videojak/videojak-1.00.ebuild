# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="VideoJak is an IP Video security assessment tool"
HOMEPAGE="http://videojak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

inherit eutils
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI=2

#DEPEND="dev-libs/log4cpp
#	dev-libs/openssl
#	dev-libs/boost"
#RDEPEND=">=dev-lang/python-2.5"

src_install() {
#        dodir /usr/share/"${PN}"
#	insinto /usr/share/"${PN}"
#	doins trust.crt
#	dosbin sslsniff
	emake DESTDIR="${D}" install || die "install failed"
#        dodoc README CHANGES
}
