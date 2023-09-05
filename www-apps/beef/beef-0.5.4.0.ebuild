# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"
inherit ruby-single

#default fails, looks too complex
RESTRICT="test"

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
SRC_URI="https://github.com/beefproject/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"

#KEYWORDS="~amd64 ~x86"

IUSE="qrcode dns geoip notifications +msf +sqlite test"

#ruby_add_rdepend "

#curl git build-essential openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev
#libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev
#autoconf libc6-dev libncurses5-dev automake libtool bison nodejs ruby-dev

RDEPEND="${RUBY_DEPS}
	dev-ruby/eventmachine
	www-servers/thin
	dev-ruby/sinatra
	dev-ruby/erubis
	dev-ruby/em-websocket
	dev-ruby/uglifier:*
	dev-ruby/mime-types:*
	dev-ruby/execjs
	dev-ruby/ansi
	dev-ruby/term-ansicolor
	dev-ruby/json:*
	dev-ruby/rubyzip
	dev-ruby/espeak-ruby
	dev-ruby/nokogiri
	dev-ruby/rake

	dev-ruby/otr-activerecord

	sqlite? ( dev-ruby/sqlite3 )

	dev-ruby/parseconfig

	msf? ( dev-ruby/msfrpc-client
		dev-ruby/xmlrpc )"

BDEPEND="${RDEPEND}
	dev-ruby/bundler:2"

#gem 'term-ansicolor', :require => 'term/ansicolor'

#fixme: add missing deps:
#geoip? maxmind-db
#notifications? rushover slack-notifier twitter
#dns? ( =dev-ruby/rubydns-0.7.3 )
#qr? ( qr4r )

#S="${WORKDIR}/all/beef-${P}/"

src_prepare() {
#	epatch "${FILESDIR}/0.4.6_unbundler.patch"
#	rm {Gemfile*,.gitignore,install*,update-beef}
	rm Gemfile.lock
	rm {.gitignore,install*,update-beef}
	# this dep isn't needed outside of development
	sed -i -e '/rubocop/d' Gemfile || die
	#as noted above, these are missing deps
#	rm -r extensions/network || die
	rm -r extensions/dns || die
	# set password
	sed -i -e 's#"beef"#"pentoo"#' config.yaml || die "failed to sed"
	#enable metasploit
	if use msf; then
		sed -i -e '/metasploit\:/ { n ; s/false/true/ }' config.yaml || die "failed to sed"
		sed -i -e 's/55552/55553/' extensions/metasploit/config.yaml || die "failed to sed"
		sed -i -e 's/"abc123"/"secure"/' extensions/metasploit/config.yaml || die "failed to sed"
		sed -i -e "s|'osx', path: '/opt/local/msf/'|'pentoo', path: '/usr/lib/metasploit/'|" extensions/metasploit/config.yaml || die "failed to sed"
	else
		sed -i -e "/^group :ext_msf do/,/^end$/d" Gemfile || die
	fi

	#even if we pass --without=blah bundler still calculates the deps and messes us up
	if ! use test; then
		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	fi

	if ! use geoip; then
		sed -i -e "/^group :geoip do/,/^end$/d" Gemfile || die
	fi

	if ! use notifications; then
		sed -i -e "/^group :ext_notifications do/,/^end$/d" Gemfile || die
	fi

	if ! use dns; then
		sed -i -e "/^group :ext_dns do/,/^end$/d" Gemfile || die
	fi

	if ! use qrcode; then
		sed -i -e "/^group :ext_qrcode do/,/^end$/d" Gemfile || die
	fi

	#not required for ruby24
	sed -i -e "/require 'msgpack'/d" core/loader.rb || die

	default
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ruby -S bundle install --local || die
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ruby -S bundle check || die
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dobin "${FILESDIR}/beef"
}
