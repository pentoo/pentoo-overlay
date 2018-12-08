# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24 ruby25"

inherit multilib ruby-fakegem

DESCRIPTION="EventMachine Proxy DSL"
HOMEPAGE="http://github.com/igrigorik/em-proxy"

LICENSE="NA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/eventmachine"
