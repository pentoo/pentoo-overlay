# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-fakegem


DESCRIPTION="set configuration for Net::HTTP"
HOMEPAGE="https://github.com/bdurand/http_configuration"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="!dev-ruby/httpconfig"
