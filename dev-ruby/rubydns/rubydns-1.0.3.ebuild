# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21"
inherit ruby-fakegem

DESCRIPTION="A tool to intercept and modify DNS requests"
HOMEPAGE="https://github.com/ioquatix/rubydns"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "=dev-ruby/celluloid-0.16.0
		=dev-ruby/celluloid-io-0.16.2
		dev-ruby/timers:4"

#celluloid ~> 0.16.0
#celluloid-io ~> 0.16.2
#timers ~> 4.0.1
