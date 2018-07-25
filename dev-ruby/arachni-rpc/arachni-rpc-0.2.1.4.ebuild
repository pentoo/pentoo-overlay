# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

inherit multilib ruby-fakegem

DESCRIPTION="Arachni-RPC is a simple and lightweight Remote Procedure Call protocol"
HOMEPAGE="https://rubygems.org/gems/arachni-rpc"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~arm ~x86"

ruby_add_rdepend "=dev-ruby/arachni-reactor-0.1*"
