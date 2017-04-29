# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"

inherit multilib ruby-fakegem

DESCRIPTION="Simple, feature rich ascii table generation library"
HOMEPAGE="http://rubygems.org/gems/terminal-table"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

ruby_add_rdepend ">=dev-ruby/unicode-display_width-1.1.1"
