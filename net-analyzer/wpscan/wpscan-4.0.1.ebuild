# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"
RUBY_FAKEGEM_EXTRAINSTALL="app bin spec"
RUBY_FAKEGEM_GEMSPEC="wpscan.gemspec"

inherit ruby-fakegem

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="https://wpscan.org/"
SRC_URI="https://github.com/wpscanteam/wpscan/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_bdepend "dev-ruby/bundler:2"
ruby_add_rdepend "
	>=dev-ruby/activesupport-7.1 <dev-ruby/activesupport-8.2
	>=dev-ruby/addressable-2.9.0
	>=dev-ruby/ethon-0.14.0 <dev-ruby/ethon-0.19
	>=dev-ruby/ferrum-0.8.0
	>=dev-ruby/fiddle-1.1.0
	>=dev-ruby/get_process_mem-0.2.5 <dev-ruby/get_process_mem-1.1.0
	>=dev-ruby/nokogiri-1.16.0
	>=dev-ruby/ostruct-0.6.0
	>=dev-ruby/public_suffix-4.0.3 <dev-ruby/public_suffix-7.1
	>=dev-ruby/ruby-progressbar-1.10.0 <dev-ruby/ruby-progressbar-1.14
	>=dev-ruby/sys-proctable-1.2.2 <dev-ruby/sys-proctable-1.4.0
	>=dev-ruby/typhoeus-1.3.0 <dev-ruby/typhoeus-1.7
	>=dev-ruby/xmlrpc-0.3.0
	>=dev-ruby/yajl-ruby-1.4.1"

each_ruby_prepare() {
	# Replace require_relative with a literal constant so the installed
	# gemspec in specifications/ can be evaluated without the lib tree
	sed -i -e "s|require_relative 'lib/wpscan/version'|module WPScan; VERSION = '${PV}'; end|" wpscan.gemspec || die
	sed -i -e '/s.add_development_dependency/d' wpscan.gemspec || die
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
