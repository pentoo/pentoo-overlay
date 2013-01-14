# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Application Layer DoS attack simulator"
HOMEPAGE="http://code.google.com/p/slowhttptest"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=" ~arm amd64 x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/1.4-add-includes.patch
	epatch "${FILESDIR}"/1.5-ldflags.patch
}

src_install() {
	dobin src/slowhttptest
}
