# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/ykclient/ykclient-2.3.ebuild,v 1.1 2010/11/20 00:28:32 flameeyes Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Yubico C client library"
SRC_URI="http://yubico-c-client.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://code.google.com/p/yubico-c-client/"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE=""

RDEPEND=">=net-misc/curl-7.21.1"
DEPEND="${RDEPEND}"

# Tests require an active network connection, we don't want to run them
RESTRICT="test"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
	find "${D}" -name '*.la' -delete || die
}
