# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

inherit multilib ruby-fakegem

DESCRIPTION="Typhoeus runs HTTP requests in parallel while cleanly encapsulating handling logic"
HOMEPAGE="https://rubygems.org/gems/typhoeus"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "virtual/ruby-ffi
	>=dev-ruby/mime-types:0"
