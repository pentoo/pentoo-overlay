# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare/radare-1.5-r1.ebuild,v 1.2 2010/09/25 15:18:56 eva Exp $

EAPI="3"

inherit base eutils flag-o-matic

DESCRIPTION="Advanced command line hexadecimail editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://www.radare.org/get/radare-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk lua readline vala ewf"

RDEPEND="
	dev-lang/python
	dev-lang/perl
	ewf? ( app-forensics/libewf )
	gtk? (
		x11-libs/gtk+:2
		x11-libs/vte )
	lua? ( dev-lang/lua )
	readline? ( sys-libs/readline )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	vala? ( >=dev-lang/vala-0.5:0 )
"

pkg_setup() {
	append-ldflags $(no-as-needed)
}


src_prepare() {
	base_src_prepare
	# fix documentation installation
	sed -i "s:doc/${PN}:doc/${PF}:g" \
		Makefile.acr global.h.acr src/Makefile.acr wscript dist/maemo/Makefile
	epatch "${FILESDIR}"/gradare-fix-64bit.patch || die
}

src_configure() {
	econf $(use_with readline) 
}

src_compile() {
#	sed -i -e '/CFLAGS/ s:include:include -I/usr/include/gtk-2.0:' src/Makefile | die "Failed to patch Makefile"
	emake -j1 || die "compile failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die "install failed"
}
