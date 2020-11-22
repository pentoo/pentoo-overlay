# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="OptionParser lib in ruby"
HOMEPAGE="https://rubygems.org/gems/opt_parse_validator"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_rdepend "dev-ruby/activesupport:*
	>=dev-ruby/addressable-2.5.2"

#each_ruby_prepare() {
#	#relax 5.1 to any
#	sed -i -e '/activesupport/,/^-/ s:^:#:' ../metadata || die
#}

#each_ruby_prepare() {
#	sed -i -e '/s.add_development_dependency/d' opt_parse_validator.gemspec
#}
