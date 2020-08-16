# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
# Requires capybara + poltergeist
RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_EXTRAINSTALL="assets"
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Bootstrap 4 rubygem for Rails / Sprockets / Hanami / etc"
HOMEPAGE="https://github.com/twbs/bootstrap-rubygem"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="4"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/autoprefixer-rails-9.1.0
	>=dev-ruby/popper_js-1.14.3:1
	>=dev-ruby/sassc-rails-2.0.0
"

all_ruby_prepare() {
	sed -i -e '/reporters/I s:^:#:' test/test_helper.rb || die
}
