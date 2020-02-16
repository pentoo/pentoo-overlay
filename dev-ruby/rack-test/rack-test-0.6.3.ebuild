# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Rack::Test is a small, simple testing API for Rack apps"
HOMEPAGE="https://github.com/brynary/rack-test"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend ">=dev-ruby/rack-1.0:*"
ruby_add_bdepend "
	test? ( >=dev-ruby/sinatra-1.2.6 )"

all_ruby_prepare() {
	rm Gemfile* || die
	sed -i -e '/bundler/d' -e '/[Cc]ode[Cc]limate/d' -e '1igem "rack", "~>1.0"' spec/spec_helper.rb || die
}
