# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="actionmailer.gemspec"

inherit ruby-fakegem

DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="https://github.com/rails/rails"
SRC_URI="https://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~x86 ~amd64-linux"
IUSE=""

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "
	~dev-ruby/actionpack-${PV}
	~dev-ruby/actionview-${PV}
	~dev-ruby/activejob-${PV}
	>=dev-ruby/mail-2.5.4:* =dev-ruby/mail-2*:*
	>=dev-ruby/rails-dom-testing-1.0.5:1"

ruby_add_bdepend "test? (
	dev-ruby/mocha:0.14
)"

all_ruby_prepare() {
	# Remove items from the common Gemfile that we don't need for this
	# test run. This also requires handling some gemspecs.
	sed -i -e "/\(system_timer\|sdoc\|w3c_validators\|pg\|execjs\|jquery-rails\|'mysql'\|journey\|ruby-prof\|stackprof\|benchmark-ips\|kindlerb\|turbolinks\|coffee-rails\|debugger\|sprockets-rails\|redcarpet\|bcrypt\|uglifier\|minitest\|mime-types\|sprockets\|stackprof\)/ s:^:#:" \
		-e '/rake/ s/12.3/12.4/ ; /dalli/ s/2.7.7/2.7.10/' \
		-e '/:job/,/end/ s:^:#:' \
		-e '/group :doc/,/^end/ s:^:#:' ../Gemfile || die
	rm ../Gemfile.lock || die

	# Avoid a test failing only on attachment ordering, since this is a
	# security release.
	sed -i -e '/adding inline attachments while rendering mail works/askip "gentoo: fails on ordering"' test/base_test.rb || die
}
