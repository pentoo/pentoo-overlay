# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24 ruby25"

inherit ruby-fakegem


DESCRIPTION="set configuration for Net::HTTP"
HOMEPAGE="https://github.com/bdurand/http_configuration"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#so old that the test syntax has changed
RESTRICT=test

DEPEND=""
RDEPEND="!dev-ruby/httpconfig"
