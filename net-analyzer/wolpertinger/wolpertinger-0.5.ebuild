# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools eutils

DESCRIPTION="a distributed portscanner"
HOMEPAGE="http://events.ccc.de/congress/2009/wiki/Wolpertinger"
SRC_URI="mirror://sourceforge/$PN/$P.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/libdnet
		 dev-libs/openssl
		 dev-db/sqlite:3
		 virtual/python"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-makefile.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	eautoreconf
}

src_install() {
	DESTDIR="${D}" emake install || die "install failed"
	# the initscript is pretty useless
	rm "${D}"/etc/init.d/wolper-init.sh
	# so are the docs, but for sake of completeness I'll add them
	dodoc README NEWS || die "failed to add docs"
}
