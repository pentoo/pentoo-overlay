# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib

DESCRIPTION="interactive ELF disambler"
HOMEPAGE="http://lida.sourceforge.net/"
SRC_URI="mirror://sourceforge/$PN/$P.tgz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/perl-tk
		 dev-libs/libdisam"

RESTRICT="strip"

src_prepare() {
	if has_multilib_profile
	then
		sed -i 's|-ggdb|-ggdb -m32|g' Makefile
	fi
}

src_install() {
	dobin lida lida_back lida.pl || die "install failed"
	dodoc README CHANGELOG TODO
}
