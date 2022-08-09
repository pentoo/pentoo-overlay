# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby27 ruby30 ruby31"

inherit ruby-fakegem

DESCRIPTION="OptionParser lib in ruby"
HOMEPAGE="https://rubygems.org/gems/opt_parse_validator"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

#No Rakefile found (looking for: rakefile, Rakefile, rakefile.rb, Rakefile.rb)
RESTRICT="test"

ruby_add_rdepend "<dev-ruby/activesupport-6.2.0:*
	>=dev-ruby/addressable-2.5.2 <dev-ruby/addressable-2.9"

#each_ruby_prepare() {
#	#relax 5.1 to any
#	sed -i -e '/activesupport/,/^-/ s:^:#:' ../metadata || die
#}

#each_ruby_prepare() {
#	sed -i -e '/s.add_development_dependency/d' opt_parse_validator.gemspec
#}
