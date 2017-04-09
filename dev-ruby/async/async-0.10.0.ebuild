# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#dev-ruby/nio4r does not support ruby 21
USE_RUBY="ruby22 ruby23"

inherit ruby-fakegem

DESCRIPTION="Asynchronous I/O framework for Ruby based on nio4r and timers."
HOMEPAGE="https://github.com/socketry/async"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/nio4r:2
	=dev-ruby/timers-4.1*
"
