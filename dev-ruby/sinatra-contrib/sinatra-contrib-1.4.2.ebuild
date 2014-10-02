# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby18 ruby19"

inherit multilib ruby-fakegem

DESCRIPTION="Collection of useful Sinatra extensions"
HOMEPAGE="https://rubygems.org/gems/sinatra-contrib"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"

ruby_add_rdepend "
	>=dev-ruby/backports-2.0
	dev-ruby/multi_json
	dev-ruby/rack-protection
	dev-ruby/rack-test
	=dev-ruby/sinatra-1.4*
	=dev-ruby/tilt-1* >=dev-ruby/tilt-1.3.3"
