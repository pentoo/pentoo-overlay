# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

#DANGER DANGER DANGER
#This currently supports one ruby at a time, don't put two in here
USE_RUBY="ruby23"
inherit eutils ruby-ng

#default fails, looks too complex
RESTRICT="test"

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
MY_COMMIT="0a415b22520057eef565e22620a8ce13dd07e440"
SRC_URI="https://github.com/beefproject/${PN}/archive/${MY_COMMIT}.zip -> ${P}.zip"

SLOT="0"
LICENSE="AGPL-3"

#https://github.com/beefproject/beef/issues/1590
#KEYWORDS="~amd64 ~x86"

IUSE="qrcode dns network geoip notifications"

#DEPEND+=""
#RDEPEND+="net-analyzer/metasploit"

#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "
	dev-ruby/eventmachine
	www-servers/thin
	dev-ruby/sinatra:2
	dev-ruby/rack:2.0
	dev-ruby/rack-protection:2
	dev-ruby/em-websocket
	dev-ruby/mime-types
	dev-ruby/uglifier
	dev-ruby/execjs
	dev-ruby/ansi
	dev-ruby/term-ansicolor
	dev-ruby/dm-core
	dev-ruby/json
	dev-ruby/data_objects
	dev-ruby/rubyzip
	dev-ruby/espeak-ruby
	dev-ruby/nokogiri
	dev-ruby/rake
	dev-ruby/therubyracer

	dev-ruby/dm-sqlite-adapter

	dev-ruby/parseconfig
	dev-ruby/erubis
	dev-ruby/dm-migrations

	dev-ruby/msfrpc-client


"
#	dns? ( =dev-ruby/rubydns-0.7.3 )
#gem 'term-ansicolor', :require => 'term/ansicolor'

#ext_network - outdated
#	dev-ruby/dm-serializer

all_ruby_unpack() {
	default_src_unpack
	mv "beef-${MY_COMMIT}" "${P}"
}

#S=${WORKDIR}/all/beef-${MY_COMMIT}/

all_ruby_prepare() {
#	epatch "${FILESDIR}/0.4.6_unbundler.patch"
#	rm {Gemfile*,.gitignore,install*,update-beef}
	rm {.gitignore,install*,update-beef}
	#as noted above, these are missing deps
#	rm -r extensions/network || die
	rm -r extensions/dns || die
	#enable metasploit
	sed -i -e '/metasploit\:/ { n ; s/false/true/ }' config.yaml || die "failed to sed"
	sed -i -e 's/55552/55553/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e 's/"abc123"/"secure"/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e "s|'osx', path: '/opt/local/msf/'|'pentoo', path: '/usr/lib/metasploit/'|" extensions/metasploit/config.yaml || die "failed to sed"

	#https://github.com/beefproject/beef/issues/1590
#	sed -i -e "/sinatra/d" Gemfile || die "sed sinatra failed"

	#even if we pass --without=blah bundler still calculates the deps and messes us up
	if ! use test; then
		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	fi

	if ! use geoip; then
		sed -i -e "/^group :geoip do/,/^end$/d" Gemfile || die
	fi

	#fixme: add missing ruby packages
	if ! use notifications; then
		sed -i -e "/^group :ext_notifications do/,/^end$/d" Gemfile || die
	fi

	#fixme: add missing ruby packages
	if ! use dns; then
		sed -i -e "/^group :ext_dns do/,/^end$/d" Gemfile || die
	fi

	#fixme: add missing ruby packages
	if ! use network; then
		sed -i -e "/^group :ext_network do/,/^end$/d" Gemfile || die
	fi

	#fixme: add missing ruby packages
	if ! use qrcode; then
		sed -i -e "/^group :ext_qrcode do/,/^end$/d" Gemfile || die
	fi

	default
}

each_ruby_prepare() {
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}

each_ruby_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dodir /usr/sbin/
	cat <<-EOF > "${ED}"/usr/sbin/beef || die
		#!/bin/sh
		cd /usr/lib/beef
		exec ${RUBY} beef "\$@"
	EOF
	fperms +x /usr/sbin/beef
}
