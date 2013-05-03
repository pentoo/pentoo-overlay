# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="VoIP war dialing suite of tools"
HOMEPAGE="http://warvox.org"
SRC_URI="https://github.com/downloads/rapid7/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="http"

DEPEND="dev-ruby/rake"
RDEPEND="net-misc/iaxclient
	media-sound/sox
	media-sound/lame
	dev-ruby/sqlite3
	dev-ruby/kissfft
	dev-python/gnuplot-py
	http? ( www-servers/mongrel )"

src_prepare() {
	sed -i 's#d ruby-kissfft d#d d#' Makefile || die
	sed -i 's#: ruby-kissfft-install#:#' Makefile || die
	sed -i 's#l web/db/production.sqlite3#l#' Makefile || die
	sed -i 's#l -#l ${CFLAGS} ${LDFLAGS} -#' src/iaxrecord/Makefile || die
	sed -i 's#rake/rdoctask#rdoc/task#' web/Rakefile || die
	sed -i -e 's:#!/usr/bin/env ruby:#!/usr/bin/env ruby18:' bin/warvox.rb || die
}

src_compile() {
	true
}

#ruby-ng_src_install() {
src_install() {
	DESTDIR="${ED}" emake install || die "install failed"
	dodir /opt/$PN
	cp -r {bin,data,docs,etc,lib,web} "${ED}"/opt/$PN/
	# I know the permissions are ugly, but that's what hdm himself
	# recommends Oo
#	chmod 644 "${ED}"/opt/$PN/web/config/session.key
#	chmod 666 "${ED}"/opt/$PN/web/log/production.log
	dosbin "${FILESDIR}"/warvox-launcher
}
