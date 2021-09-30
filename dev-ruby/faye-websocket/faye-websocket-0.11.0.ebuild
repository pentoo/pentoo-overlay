# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="Standards-compliant WebSocket server and client"
HOMEPAGE="https://github.com/faye/faye-websocket-ruby"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"

ruby_add_rdepend "
	dev-ruby/eventmachine
	dev-ruby/websocket-driver:*
"
