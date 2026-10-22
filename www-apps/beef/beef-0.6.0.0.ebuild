# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"
inherit ruby-single

#default fails, looks too complex
RESTRICT="test"

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
SRC_URI="https://github.com/beefproject/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"

# Upstream 0.6.0.0 moved to ActiveRecord 8 (Gemfile: gem 'activerecord',
# '~> 8.0'); ::gentoo no longer ships anything older than 7.1.5.1, so the
# 0.5.4.0 ebuild's < 7.1 constraint can no longer resolve.
#KEYWORDS="~amd64 ~x86"

IUSE="qrcode dns geoip notifications +msf +sqlite test"

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

	dev-ruby/activerecord:8.0
	>=dev-ruby/otr-activerecord-2.5.0

	sqlite? ( dev-ruby/sqlite3 )

	dev-ruby/parseconfig

	msf? ( dev-ruby/msfrpc-client
		dev-ruby/xmlrpc )"

BDEPEND="${RDEPEND}
	dev-ruby/bundler:2"

#fixme: add missing deps:
#geoip? maxmind-db
#notifications? rushover slack-notifier
#dns? async-dns
#qr? qr4r

src_prepare() {
	rm Gemfile.lock
	rm {.gitignore,install*,update-beef}
	# this dep isn't needed outside of development
	sed -i -e '/rubocop/d' Gemfile || die
	#as noted above, these are missing deps
	rm -r extensions/dns || die
	# set password
	sed -i -e 's#"beef"#"pentoo"#' config.yaml || die "failed to sed"
	# upstream forgot to bump the version string in config.yaml for the
	# 0.6.0.0 release (the VERSION file is correct); keep the banner honest
	sed -i -e "s/^    version: '.*'/    version: '${PV}'/" config.yaml || die "failed to sed"
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

	default
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ruby -S bundle install --local || die
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ruby -S bundle check || die
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dobin "${FILESDIR}/beef"
}
