# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="sslstrip remove https and forwards http"
HOMEPAGE="http://www.thoughtcrime.org/software/sslsniff/"
SRC_URI="http://www.thoughtcrime.org/software/${PN}/${P}.tar.gz"

inherit eutils
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI=2

RDEPEND=">=dev-lang/python-2.5"

src_install() {
        dodir /usr/share/"${PN}"
	insinto /usr/share/"${PN}"
	doins trust.crt
	dosbin sslsniff
        dodoc README CHANGES
}
