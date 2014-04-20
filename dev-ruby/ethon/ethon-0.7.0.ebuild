# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby18 ruby19"

inherit multilib ruby-fakegem

DESCRIPTION="Very lightweight libcurl wrapper"
HOMEPAGE="https://rubygems.org/gems/ethon"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"

ruby_add_rdepend "virtual/ruby-ffi
	>=dev-ruby/ffi-1.3.0
	>=dev-ruby/mime-types-1.18"
