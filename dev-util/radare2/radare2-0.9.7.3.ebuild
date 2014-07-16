# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare2/radare2-0.9.ebuild,v 2.0 2012/04/04 06:20:21 akochkov Exp $

EAPI=5
inherit base eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="https://github.com/radare/${PN}/archive/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ewf ssl"
#capstone is not really optional anymore

RDEPEND=">dev-util/capstone-2.1.2
	!dev-util/radare2-capstone
	ssl? ( dev-libs/openssl:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

#fix upstream's insanity
S=${WORKDIR}/radare2-${P}-1

src_configure() {
	econf $(use ssl || echo --without-openssl ) \
		$(use ewf || echo --without-ewf ) \
		$(use debug || echo --disable-debugger ) \
		--with-syscapstone
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install
}
