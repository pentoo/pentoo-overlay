# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby18 ruby19"

inherit multilib ruby-fakegem

DESCRIPTION="Typhoeus runs HTTP requests in parallel while cleanly encapsulating handling logic"
HOMEPAGE="https://rubygems.org/gems/typhoeus"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "virtual/ruby-ffi
	>=dev-ruby/mime-types-1.18"
