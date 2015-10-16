# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

inherit multilib ruby-fakegem

DESCRIPTION="EventMachine-based client and server implementation of Arachni-RPC"
HOMEPAGE="https://rubygems.org/gems/arachni-rpc-em"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~arm ~x86"

ruby_add_rdepend "=dev-ruby/arachni-rpc-0.1.3
		>=dev-ruby/em-synchrony-1.0.0
		=dev-ruby/eventmachine-1.0* >=dev-ruby/eventmachine-1.0.0"
