# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

#DANGER DANGER DANGER
#This currently supports one ruby at a time, don't put two in here
USE_RUBY="ruby23"

inherit ruby-fakegem eutils
#default fails, looks complex
RESTRICT="test"

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
SRC_URI="https://github.com/beefproject/beef/archive/${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="dns network"

DEPEND+=""
RDEPEND+="net-analyzer/metasploit"

#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "(
	dev-ruby/eventmachine
	www-servers/thin
	dev-ruby/sinatra:*
	dev-ruby/rack:1.6
	=dev-ruby/em-websocket-0.3*
	dev-ruby/uglifier:*
	dev-ruby/ansi
	dev-ruby/term-ansicolor
	dev-ruby/dm-core
	dev-ruby/json:*
	dev-ruby/data_objects
	dev-ruby/dm-sqlite-adapter
	dev-ruby/parseconfig
	dev-ruby/erubis
	dev-ruby/dm-migrations
	dev-ruby/msfrpc-client
	dev-ruby/rubyzip:1
	>=dev-ruby/rubydns-0.7.0
	dev-ruby/sqlite3
	dev-ruby/mime-types:*
	)"

#rubydns", "0.7.0"     # DNS extension
#geoip"                # geolocation support
#dm-serializer"        # network extension
#qr4r"                 # QRcode extension

all_ruby_unpack() {
	default
	mv "beef-${P}" "${P}"
}

all_ruby_prepare() {
	epatch "${FILESDIR}/0.4.6_unbundler.patch"
	rm {Gemfile*,.gitignore,install*,update-beef}
	#as noted above, these are missing deps
	rm -r extensions/network || die
	rm -r extensions/dns || die
	#enable metasploit
	sed -i -e '/metasploit\:/ { n ; s/false/true/ }' config.yaml || die "failed to sed"
	sed -i -e 's/55552/55553/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e 's/"abc123"/"secure"/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e "s|'osx', path: '/opt/local/msf/'|'pentoo', path: '/usr/lib/metasploit/'|" extensions/metasploit/config.yaml || die "failed to sed"
	default
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
