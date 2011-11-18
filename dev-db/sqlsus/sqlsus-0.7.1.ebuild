# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="MySQL injection and takeover tool"
HOMEPAGE="http://sqlsus.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/WWW-Mechanize
	dev-perl/LWP-UserAgent-Determined
	dev-perl/HTML-LinkExtractor
	dev-perl/Term-ReadLine-Gnu"
# libdbd-sqlite3-perl

src_prepare() {
	sed -i -e 's:use lib '\''lib'\'':use lib "/usr/share/sqlsus/lib":' \
		 sqlsus || die
}

src_install() {
	insinto /etc/sqlsus
	doins "${FILESDIR}"/sqlsus.conf
	dobin sqlsus
	dodir /usr/share/sqlsus
	insinto /usr/share/sqlsus
	doins -r lib
	dodoc README CHANGELOG
}
