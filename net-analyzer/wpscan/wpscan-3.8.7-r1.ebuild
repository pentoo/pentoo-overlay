# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"
RUBY_FAKEGEM_EXTRAINSTALL="app bin spec"
RUBY_FAKEGEM_GEMSPEC="wpscan.gemspec"

inherit ruby-fakegem

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
SRC_URI="https://github.com/wpscanteam/wpscan/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

ruby_add_bdepend "dev-ruby/bundler"
ruby_add_rdepend "
	=dev-ruby/cms_scanner-0.12*
	dev-ruby/concurrent-ruby
	dev-ruby/i18n
	dev-ruby/minitest
	dev-ruby/thread_safe
	dev-ruby/tzinfo
	dev-ruby/activesupport
	dev-ruby/public_suffix
	dev-ruby/addressable
	dev-ruby/ffi
	dev-ruby/get_process_mem
	dev-ruby/nokogiri
	dev-ruby/opt_parse_validator
	dev-ruby/ruby-progressbar
	dev-ruby/sys-proctable
	dev-ruby/ethon
	dev-ruby/typhoeus
	dev-ruby/xmlrpc
	dev-ruby/yajl-ruby
"

each_ruby_prepare() {
#https://github.com/wpscanteam/wpscan/issues/1266
#	sed -i "s|'activesupport', '~> 5.1'|'activesupport'|g" wpscan.gemspec
#	sed -i -e '/activesupport/,/^-/ s:^:#:' ../metadata || die
	sed -i -e '/s.add_development_dependency/d' wpscan.gemspec
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
