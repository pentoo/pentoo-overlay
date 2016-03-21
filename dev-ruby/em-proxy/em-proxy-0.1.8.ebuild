# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
USE_RUBY="ruby20 ruby21 ruby22"

inherit multilib ruby-fakegem

DESCRIPTION="EventMachine Proxy DSL"
HOMEPAGE="http://github.com/igrigorik/em-proxy"

LICENSE="NA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/eventmachine"
