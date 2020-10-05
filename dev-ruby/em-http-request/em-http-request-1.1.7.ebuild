# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26"

inherit ruby-fakegem

DESCRIPTION=""
HOMEPAGE=""

KEYWORDS="amd64 ~arm64 x86"
LICENSE=""
SLOT="0"

ruby_add_rdepend "
	>=dev-ruby/addressable-2.3.4
	dev-ruby/cookiejar
	>=dev-ruby/em-socksify-0.3
	>=dev-ruby/eventmachine-1.0.3
	>=dev-ruby/http_parser_rb-0.6.0
"
