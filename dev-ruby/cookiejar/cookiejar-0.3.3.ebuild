# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="Allows for parsing and returning cookies in Ruby HTTP client code"
HOMEPAGE="https://github.com/dwaite/cookiejar"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
