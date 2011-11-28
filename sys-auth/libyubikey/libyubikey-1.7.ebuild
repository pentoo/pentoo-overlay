# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libyubikey/libyubikey-1.6.ebuild,v 1.1 2010/10/23 16:38:54 flameeyes Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Yubico C low-level library"
SRC_URI="http://yubico-c.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://code.google.com/p/yubico-c/"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-rpath.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS || die
	find "${D}" -name '*.la' -delete || die
}
