# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby18 ruby19"

inherit multilib ruby-fakegem

DESCRIPTION="EventMachine-based client and server implementation of Arachni-RPC"
HOMEPAGE="https://rubygems.org/gems/arachni-rpc-em"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~arm ~x86"

ruby_add_rdepend "=dev-ruby/arachni-rpc-0.1.3
		>=dev-ruby/em-synchrony-1.0.0
		=dev-ruby/eventmachine-1.0* >=dev-ruby/eventmachine-1.0.0"
