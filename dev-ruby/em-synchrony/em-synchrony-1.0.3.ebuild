# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
USE_RUBY="ruby18 ruby19"

inherit ruby-fakegem

DESCRIPTION="Fiber aware EventMachine libraries"
HOMEPAGE="http://rubygems.org/gems/em-synchrony"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 "
IUSE=""

ruby_add_rdepend ">=dev-ruby/eventmachine-1.0.0"
