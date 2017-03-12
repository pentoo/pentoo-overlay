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

#ruby_add_bdepend "test? (
#	bundler ~> 1.10
#	pry >= 0
#	rake ~> 10.0
#	rspec >= 3.0
#	term-ansicolor >= 0
#	)"
