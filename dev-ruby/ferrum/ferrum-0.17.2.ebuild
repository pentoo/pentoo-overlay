# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Headless Chrome Ruby API"
HOMEPAGE="https://github.com/rubycdp/ferrum"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

ruby_add_rdepend "
	dev-ruby/addressable
	dev-ruby/base64
	dev-ruby/concurrent-ruby
	dev-ruby/webrick
	dev-ruby/websocket-driver"
