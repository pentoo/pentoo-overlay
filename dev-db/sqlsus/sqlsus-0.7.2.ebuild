# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="MySQL injection and takeover tool"
HOMEPAGE="http://sqlsus.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P/_/}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/Switch
	dev-perl/WWW-Mechanize
	dev-perl/LWP-UserAgent-Determined
	dev-perl/DBD-SQLite
	dev-perl/HTML-LinkExtractor
	dev-perl/Term-ReadLine-Gnu"
# libdbd-sqlite3-perl liblwp-protocol-socks-perl sqlite3

src_prepare() {
	default
#	sed -i 's|#!/usr/bin/perl -w|#!/usr/bin/env perl|' sqlsus
	sed -i -e "s:use lib 'lib':use lib '/usr/share/sqlsus/lib':" \
	sqlsus || die
}

src_install() {
	insinto /etc/sqlsus
	doins "${FILESDIR}"/sqlsus.conf
	dobin sqlsus
	insinto /usr/share/sqlsus
	doins -r lib
	dodoc README CHANGELOG
}
