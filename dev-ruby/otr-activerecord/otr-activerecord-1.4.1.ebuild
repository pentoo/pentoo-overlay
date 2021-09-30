# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="Off The Rails ActiveRecord: Use ActiveRecord with Grape, Sinatra, Rack"
HOMEPAGE="https://rubygems.org/gems/otr-activerecord"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	|| ( dev-ruby/activerecord:5.2 dev-ruby/activerecord:6.0 )
	dev-ruby/hashie-forbidden_attributes
	"
