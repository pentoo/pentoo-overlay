# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Ruby driver for connecting to, querying, and manipulating MongoDB databases"
HOMEPAGE="https://rubygems.org/gems/mongo"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "
	dev-ruby/base64
	>=dev-ruby/bson-4.14.1
"
