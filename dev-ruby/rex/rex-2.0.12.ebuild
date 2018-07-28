# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24"
#RUBY_FAKEGEM_RECIPE_TEST="rspec3"
#RUBY_FAKEGEM_TASK_DOC=""
#RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="A variety of classes useful for security testing and exploit development"
HOMEPAGE="https://github.com/rapid7/rex/"

LICENSE="BSD-3-CLAUSE"

SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

# doesn't seem to actually run any tests
#RESTRICT=test

ruby_add_bdepend "dev-ruby/filesize
	dev-ruby/jsobfu
	dev-ruby/json:2
	=dev-ruby/metasm-1*
	=dev-ruby/nokogiri-1*
	dev-ruby/rb-readline"
