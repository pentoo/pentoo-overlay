# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Off The Rails ActiveRecord: Use ActiveRecord with Grape, Sinatra, Rack"
HOMEPAGE="https://rubygems.org/gems/otr-activerecord"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	dev-ruby/activerecord
	dev-ruby/hashie-forbidden_attributes
	"
