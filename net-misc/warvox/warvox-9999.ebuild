# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2

DESCRIPTION="VoIP war dialing suite of tools"
HOMEPAGE="http://warvox.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="-*"
IUSE="http"
#ESVN_REPO_URI="http://www.metasploit.com/svn/warvox/trunk/"
EGIT_REPO_URI="https://github.com/rapid7/warvox.git"

DEPEND="dev-ruby/rake"
RDEPEND="dev-ruby/rails:3.2
	dev-ruby/activesupport:3.2
	media-sound/sox
	media-sound/lame
	dev-ruby/sqlite3
	dev-python/gnuplot-py
	dev-ruby/bundler
	dev-ruby/mail:2.5
	dev-ruby/pg
	dev-ruby/will_paginate:3
	dev-ruby/abstract
	http? ( www-servers/mongrel )"

# we are missing a lot of deps here:
#gem 'authlogic'
#gem 'rails-settings-cached'
#gem 'twitter-bootstrap-rails'
#gem 'formtastic'
#gem 'formtastic-bootstrap'
#gem 'rails_bootstrap_navbar'
#gem 'less-rails-bootstrap'
#gem 'therubyracer'
#gem 'reportable', :git => 'git://github.com/hmoore-r7/reportable.git', :require => 'saulabs/reportable'

#Bundler is a tricky to deal with. We might need adapt tricks from dev-ruby/radiant
#See the following blog post for more details:
#http://blog.flameeyes.eu/2010/08/18/gentoo-ruby-less-is-more

src_prepare(){
	#Remove 'smart' commands from the Makefile
	#do not run verify_install.rb
	sed -i 's|^all: test|all: install|' Makefile || die
	#do not run bundler and db sections
#	sed -i 's|\install: bundler dtmf2num ruby-kissfft db|install: dtmf2num ruby-kissfft-install|' Makefile || die
	sed -i 's|\install: bundler|install: |' Makefile || die
	sed -i "s|bundle exec||" Makefile || die
	#do not pull external packages
#	sed -i -e "s:^gem 'rails'.*:gem 'rails':" web/Gemfile  || die
#	sed -i -e "s:^gem 'will_paginate'.*:gem 'will_paginate':" web/Gemfile  || die
	rm {Gemfile,Gemfile.lock}
}

src_install() {
	DESTDIR="${D}" emake install || die "install failed"
	dodir /opt/$PN
	cp -R "${S}"/* "${ED}"/opt/${PN}/ || die "Copy files failed"

	# I know the permissions are ugly, but that's what hdm himself
	# recommends Oo
#	chmod 644 "${D}"/opt/$PN/web/config/session.key
#	chmod 666 "${D}"/opt/$PN/web/log/production.log
	dosbin "${FILESDIR}"/warvox-launcher
}

pkg_postinst() {
	elog "You need to configure a postgresql now. Execute following under root:"
	elog " /opt/warvox/bin/verify_install.rb and follow instructions"
	elog " cd /opt/warvox/web; RAILS_ENV=production rake db:migrate"
	elog ""
	elog "Start WarVOX with warvox-launcher"
	elog "Login to http://127.0.0.1:7777/"
}
