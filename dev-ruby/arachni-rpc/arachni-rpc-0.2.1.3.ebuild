# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21 ruby22"

inherit multilib ruby-fakegem

DESCRIPTION="Arachni-RPC is a simple and lightweight Remote Procedure Call protocol"
HOMEPAGE="https://rubygems.org/gems/arachni-rpc"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~arm ~x86"

ruby_add_rdepend "
	>=dev-ruby/arachni-reactor-0.1.1
"
