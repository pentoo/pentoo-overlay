# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
USE_RUBY="ruby19"

inherit ruby-fakegem webapp

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
SRC_URI="https://github.com/beefproject/beef/archive/${P}.tar.gz"

LICENSE="AGPL-3"
KEYWORDS=""
IUSE=""

DEPEND+=""
RDEPEND+="dev-lang/php[filter]
	net-analyzer/metasploit"

#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "(
	dev-ruby/sinatra
	dev-ruby/term-ansicolor
	dev-ruby/json
	dev-ruby/erubis
	dev-ruby/eventmachine
	dev-ruby/sqlite3
 )"

#bundler
#www-servers/thin
#dev-db/sqlite:3
#ANSI
#dm-core
#data_objects
#dm-sqlite-adapter
#parseconfig
#dm-migrations
#msfrpc-client

src_install() {
	webapp_src_preinst
	cp -R beef/* "${D}"/${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}/include
	webapp_serverowned -R ${MY_HTDOCSDIR}/cache
	webapp_src_install
}
