# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="MySQL injection and takeover tool"
HOMEPAGE="http://sqlsus.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# libdbd-sqlite3-perl

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/WWW-Mechanize
	dev-perl/Term-ReadLine-Gnu"

src_prepare() {
	cd sqlsus-0.5rc1

	sed -i -e 's:use lib '\''lib'\'':use lib "/usr/share/sqlsus/lib":' \
		 sqlsus || die
}

src_compile() {
	einfo "nothing to compile"
	true
}

src_install() {
	cd sqlsus-0.5rc1

	insinto /etc/sqlsus
	doins ${FILESDIR}/sqlsus.conf || die "config install failed"

	dobin sqlsus || die "install failed"

	dodir /usr/share/sqlsus
	insinto /usr/share/sqlsus
	doins -r lib || die

	dodoc README CHANGELOG || die
}
