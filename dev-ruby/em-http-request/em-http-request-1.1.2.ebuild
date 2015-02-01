# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem versionator

DESCRIPTION="EventMachine based, async HTTP Request client"
HOMEPAGE="http://github.com/igrigorik/em-http-request"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"

KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/addressable-2.3.4
	dev-ruby/cookiejar
	>=dev-ruby/eventmachine-1.0.3
	>=dev-ruby/http_parser_rb-0.6.0
	>=dev-ruby/em-socksify-0.3.0"
