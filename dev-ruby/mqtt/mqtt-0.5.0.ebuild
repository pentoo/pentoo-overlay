# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby22 ruby23 ruby24 ruby25"

inherit ruby-fakegem

DESCRIPTION="Pure Ruby gem that implements the MQTT protocol"
HOMEPAGE="http://github.com/njh/ruby-mqtt"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
