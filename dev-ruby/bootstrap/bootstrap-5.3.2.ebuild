# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
# Requires capybara + poltergeist
RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_EXTRAINSTALL="assets"
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Bootstrap rubygem for Rails / Sprockets / Hanami / etc"
HOMEPAGE="https://github.com/twbs/bootstrap-rubygem"
LICENSE="MIT"

#wait for ~dev-ruby/sassc-rails
KEYWORDS="~amd64"
SLOT="5"

ruby_add_rdepend "
	>=dev-ruby/autoprefixer-rails-9.1.0
	>=dev-ruby/popper_js-2.11.8:2
"

all_ruby_prepare() {
	sed -i -e '/reporters/I s:^:#:' test/test_helper.rb || die
}
