# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#Warning: add one ruby at a time
USE_RUBY="ruby24"
inherit eutils ruby-ng

#default fails, looks too complex
RESTRICT="test"

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
#MY_COMMIT="d237c95465a1ad4065cdbdd3972b637f3f93341b"
SRC_URI="https://github.com/beefproject/${PN}/archive/${P}.tar.gz -> ${P}.tar.gz"
#https://github.com/beefproject/beef/archive/beef-0.4.7.1.tar.gz

SLOT="0"
LICENSE="AGPL-3"

KEYWORDS="~amd64 ~x86"

IUSE="qrcode dns +network geoip notifications +msf +sqlite"

#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

#we use bundler in the ebuild, it must be installed first but it's not an rdepend
ruby_add_bdepend "dev-ruby/bundler"

ruby_add_rdepend "
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
	dev-ruby/dm-core
	dev-ruby/json:*
	dev-ruby/data_objects
	dev-ruby/rubyzip
	dev-ruby/espeak-ruby
	dev-ruby/nokogiri
	dev-ruby/rake

	sqlite? ( dev-ruby/dm-sqlite-adapter )

	dev-ruby/parseconfig
	dev-ruby/erubis
	dev-ruby/dm-migrations

	msf? ( dev-ruby/msfrpc-client
		dev-ruby/xmlrpc )
"
#gem 'term-ansicolor', :require => 'term/ansicolor'

#fixme: add missing deps:
#postgres? dm-postgres-adapter
#mysql? dm-mysql-adapter
#geoip? geoip
#notifications? rushover twitter
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

	if ! use network; then
		sed -i -e "/^group :ext_network do/,/^end$/d" Gemfile || die
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
