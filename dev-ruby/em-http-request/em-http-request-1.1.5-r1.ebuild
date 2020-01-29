# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25"

inherit ruby-fakegem

DESCRIPTION="EventMachine based, async HTTP Request client"
HOMEPAGE="http://github.com/igrigorik/em-http-request"

LICENSE="MIT"
#SLOT="$(ver_cut 1-2)"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/addressable-2.3.4
	dev-ruby/cookiejar
	>=dev-ruby/eventmachine-1.0.3
	>=dev-ruby/http_parser_rb-0.6.0
	>=dev-ruby/em-socksify-0.3.0"
