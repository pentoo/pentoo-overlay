# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby30"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
# Requires capybara + poltergeist
RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_EXTRAINSTALL="assets"
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Bootstrap rubygem for Rails / Sprockets / Hanami / etc"
HOMEPAGE="https://github.com/twbs/bootstrap-rubygem"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="5"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/popper_js-2.9.2:2
	>=dev-ruby/sassc-rails-2.0.0
	>=dev-ruby/autoprefixer-rails-9.1.0
"

all_ruby_prepare() {
	sed -i -e '/reporters/I s:^:#:' test/test_helper.rb || die
}
