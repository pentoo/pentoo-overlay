# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="An Action Dispatch session store backed by an Active Record class"
HOMEPAGE="https://github.com/rails/activerecord-session_store"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	|| ( dev-ruby/activerecord:7.0 dev-ruby/activerecord:6.1 dev-ruby/activerecord:6.0 )
	|| ( dev-ruby/actionpack:7.0 dev-ruby/actionpack:6.1 dev-ruby/actionpack:6.0 )
	|| ( dev-ruby/rack:3.0 dev-ruby/rack:2.2  )
	|| ( dev-ruby/railties:7.0 dev-ruby/railties:6.1 dev-ruby/railties:6.0 )
	>=dev-ruby/multi_json-1.11.2 =dev-ruby/multi_json-1*
"
ruby_add_bdepend "test? ( dev-ruby/sqlite3 )"
