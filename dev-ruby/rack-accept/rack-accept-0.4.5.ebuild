# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="HTTP Accept, Accept-Charset, Accept-Encoding, and Accept-Language for Ruby/Rack"
HOMEPAGE="https://github.com/mjackson/rack-accept"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	>=dev-ruby/rack-0.4
"
