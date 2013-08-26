# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multi_json/multi_json-1.0.4.ebuild,v 1.10 2013/08/23 22:44:24 zerochaos Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="doc:rdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="multi_json.gemspec"

inherit ruby-fakegem

DESCRIPTION="A gem to provide swappable JSON backends"
HOMEPAGE="http://github.com/intridea/multi_json"
LICENSE="MIT"

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

ruby_add_rdepend "|| ( >=dev-ruby/json-1.4 >=dev-ruby/yajl-ruby-0.7 =dev-ruby/activesupport-3* )"

ruby_add_bdepend "doc? ( dev-ruby/rspec:2 )"

ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/json )"

USE_RUBY=ruby18 ruby_add_bdepend "test? ( dev-ruby/yajl-ruby )"
USE_RUBY=ruby19 ruby_add_bdepend "test? ( dev-ruby/yajl-ruby )"
USE_RUBY=ree18 ruby_add_bdepend "test? ( dev-ruby/yajl-ruby )"

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/d' Rakefile spec/helper.rb || die "Unable to remove bundler."
	rm Gemfile || die "Unable to remove bundler Gemfile."

	# Remove simplecov support since we only care about the test results
	# and this avoids another dependency.
	sed -i -e '/[Ss]imple[Cc]ov/d' spec/helper.rb || die

	# Provide version otherwise provided by bundler.
	sed -i -e "s/#{MultiJson::VERSION}/${PV}/" Rakefile || die
}
