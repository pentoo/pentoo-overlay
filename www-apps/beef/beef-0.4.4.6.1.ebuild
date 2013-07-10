# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
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
	=dev-ruby/eventmachine-1.0.3
	www-servers/thin
	=dev-ruby/sinatra-1.4.2
	=dev-ruby/rack-1.5.2
	>=dev-ruby/em-websocket-0.3.6
	>=dev-ruby/jsmin-1.0.1
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
	dev-ruby/twitter
	dev-ruby/sqlite3 )"

src_prepare() {
	cd all
	mv "beef-${P}" "${P}"
	epatch "${FILESDIR}/${PV}_unbundler.patch"
	rm "${P}"/{Gemfile*,.gitignore,install*}
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/all/"${P}"/* "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosbin "${FILESDIR}"/beef
}
