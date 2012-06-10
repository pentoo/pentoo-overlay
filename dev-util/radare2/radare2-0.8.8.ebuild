# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare2/radare2-0.8.8.ebuild,v 1.0 2011/12/06 06:20:21 akochkov Exp $

EAPI="3"
inherit base eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://www.radare.org/get/radare2-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="readline"

RDEPEND="readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	base_src_prepare
}

src_configure() {
	econf $(use_with readline)
}

src_compile() {
	emake -j1 || die "compile failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die "install failed"
}
