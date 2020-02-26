# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

inherit ruby-fakegem

DESCRIPTION="An Action Dispatch session store backed by an Active Record class"
HOMEPAGE="https://github.com/rails/activerecord-session_store"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	|| ( dev-ruby/actionpack:4.2 dev-ruby/actionpack:5.2 dev-ruby/actionpack:6.0 )
	|| ( dev-ruby/activerecord:4.2  dev-ruby/activerecord:5.2 dev-ruby/activerecord:6.0 )
	|| ( dev-ruby/rack:2.0 dev-ruby/rack:1.6 )
	|| ( dev-ruby/railties:4.2 dev-ruby/railties:5.2 dev-ruby/railties:4.2 dev-ruby/railties:6.0 )
	>=dev-ruby/multi_json-1.11.2 =dev-ruby/multi_json-1*
	dev-ruby/sqlite3
"
