# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion

DESCRIPTION="Telephone system auditing tool"
HOMEPAGE="http://warvox.org/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-ruby/rake"
RDEPEND="dev-ruby/sqlite3-ruby
		 net-misc/iaxclient
		 sci-visualization/gnuplot
		 media-sound/sox"

ESVN_REPO_URI="http://metasploit.com/svn/warvox/trunk/"

src_install() {
	DESTDIR="${D}" emake install || die "install failed"
	dodir /opt/$PN
	cp -r {bin,data,docs,etc,lib,web} "${D}"/opt/$PN/
	# I know the permissions are ugly, but that's what hdm himself
	# recommends Oo
	chmod 644 "${D}"/opt/$PN/web/config/session.key
	chmod 666 "${D}"/opt/$PN/web/log/production.log
	dobin "${FILESDIR}"/warvox-launcher
}
