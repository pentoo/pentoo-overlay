# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare2/radare2-0.9.ebuild,v 2.0 2012/04/04 06:20:21 akochkov Exp $

EAPI="4"
inherit base eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://www.radare.org/get/radare2-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ssl ewf gmp debug"

RDEPEND="ssl? ( dev-libs/openssl ) \
		gmp? ( dev-libs/gmp ) \
		"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use ssl || echo --without-ssl ) \
		$(use gmp || echo --without-gmp ) \
		$(use ewf || echo --without-ewf ) \
		$(use debug || echo --without-debug )
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install || die "install failed"
}

