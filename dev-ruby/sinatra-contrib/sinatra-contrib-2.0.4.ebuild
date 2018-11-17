# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby23 ruby24"

inherit multilib ruby-fakegem

DESCRIPTION="Collection of useful Sinatra extensions"
HOMEPAGE="https://rubygems.org/gems/sinatra-contrib"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"

ruby_add_rdepend "
	dev-ruby/activesupport:4.0
	>=dev-ruby/backports-2.8.2
	dev-ruby/multi_json
	>=dev-ruby/mustermann-1.0
	dev-ruby/rack-protection
	>=dev-ruby/sinatra-2.0.4
	|| ( dev-ruby/tilt:0 dev-ruby/tilt:2 )"
