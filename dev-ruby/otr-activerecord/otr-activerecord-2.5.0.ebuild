# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"

inherit ruby-fakegem

DESCRIPTION="Off The Rails ActiveRecord: use ActiveRecord outside Rails (Sinatra, Rack, Grape)"
HOMEPAGE="https://github.com/jhollinger/otr-activerecord"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Upstream 2.5.0 gemspec: activerecord >= 6.0, < 8.1 (single runtime dep;
# the old hashie-forbidden_attributes dependency was dropped after 2.1.2).
ruby_add_rdepend "
	dev-ruby/activerecord
	"
