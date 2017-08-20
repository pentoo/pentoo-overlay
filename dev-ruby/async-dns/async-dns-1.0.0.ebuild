# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23 ruby24"
inherit ruby-fakegem

DESCRIPTION="An asynchronous DNS resolver and server."
HOMEPAGE="https://github.com/socketry/async-dns"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/async-io-1.0 =dev-ruby/async-io-1*"
