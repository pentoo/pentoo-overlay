# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="VoIP war dialing suite of tools"
HOMEPAGE="http://warvox.org"
SRC_URI="https://github.com/downloads/rapid7/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="http"

#build-essential libiaxclient-dev sox lame ruby ruby-dev rake rubygems libopenssl-ruby 
#libreadline-ruby libsqlite3-ruby gnuplot

#DEPEND="net-libs/libiaxclient[video]

DEPEND="dev-ruby/rake"
RDEPEND="net-misc/iaxclient
	media-sound/sox
	media-sound/lame
	dev-ruby/sqlite3
	dev-python/gnuplot-py
	http? ( www-servers/mongrel )"

src_install() {
	ewarn "Only supports ruby 1.8, and I don't know how to make the ebuild force that"
	DESTDIR="${D}" emake install || die "install failed"
	dodir /opt/$PN
	cp -r {bin,data,docs,etc,lib,web} "${D}"/opt/$PN/
	# I know the permissions are ugly, but that's what hdm himself
	# recommends Oo
	chmod 644 "${D}"/opt/$PN/web/config/session.key
	chmod 666 "${D}"/opt/$PN/web/log/production.log
	dobin "${FILESDIR}"/warvox-launcher
}
