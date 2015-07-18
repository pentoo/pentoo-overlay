# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

USE_RUBY="ruby19"

inherit ruby-fakegem eutils

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
SRC_URI="https://github.com/beefproject/beef/archive/${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND+=""
RDEPEND+="net-analyzer/metasploit"

#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "(
	dev-ruby/eventmachine
	www-servers/thin
	dev-ruby/sinatra
	dev-ruby/rack
	=dev-ruby/em-websocket-0.3*
	dev-ruby/uglifier
	dev-ruby/ansi
	dev-ruby/term-ansicolor
	dev-ruby/dm-core
	dev-ruby/json
	dev-ruby/data_objects
	dev-ruby/dm-sqlite-adapter
	dev-ruby/parseconfig
	dev-ruby/erubis
	dev-ruby/dm-migrations
	dev-ruby/msfrpc-client
	dev-ruby/rubyzip:1
	>=dev-ruby/rubydns-0.7.0
	dev-ruby/sqlite3
	)"

#rubydns", "0.7.0"     # DNS extension
#geoip"                # geolocation support
#dm-serializer"        # network extension
#qr4r"                 # QRcode extension

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	#upstream smoked something here
	mv "beef-${P}" "${P}"
	cd "${S}"
}

src_prepare() {
	epatch "${FILESDIR}/0.4.5_unbundler.patch"
	rm {Gemfile*,.gitignore,install*,update-beef}
	#enable metasploit
	sed -i -e '/metasploit\:/ { n ; s/false/true/ }' config.yaml || die "failed to sed"
	sed -i -e 's/55552/55553/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e 's/"abc123"/"secure"/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e "s|'osx', path: '/opt/local/msf/'|'pentoo', path: '/usr/lib/metasploit/'|" extensions/metasploit/config.yaml || die "failed to sed"
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosbin "${FILESDIR}"/beef
}
