# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"
inherit eutils ruby-single

#default fails, looks too complex
RESTRICT="test"

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
SRC_URI="https://github.com/beefproject/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"

#WIP
#KEYWORDS="~amd64 ~x86"

IUSE="qrcode dns geoip notifications +msf +sqlite"

#ruby_add_rdepend "

#curl git build-essential openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev
#libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev
#autoconf libc6-dev libncurses5-dev automake libtool bison nodejs ruby-dev

RDEPEND="${RUBY_DEPS}
	dev-ruby/eventmachine
	www-servers/thin
	dev-ruby/sinatra:2
	dev-ruby/rack:2.0
	dev-ruby/rack-protection:2
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
	dev-ruby/erubis

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

all_ruby_unpack() {
	default_src_unpack
	mv "beef-${P}" "${P}"
}

#S="${WORKDIR}/all/beef-${P}/"

all_ruby_prepare() {
#	epatch "${FILESDIR}/0.4.6_unbundler.patch"
#	rm {Gemfile*,.gitignore,install*,update-beef}
	rm {.gitignore,install*,update-beef}
	#as noted above, these are missing deps
#	rm -r extensions/network || die
	rm -r extensions/dns || die
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
}

each_ruby_prepare() {
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}

each_ruby_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dobin "${FILESDIR}/beef"
}
