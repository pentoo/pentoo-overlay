# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25"
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
	dev-ruby/addressable
	dev-ruby/activesupport:*
	>=dev-ruby/cms_scanner-0.7.1
	dev-ruby/memory_profiler
	dev-ruby/yajl-ruby"

each_ruby_prepare() {
#https://github.com/wpscanteam/wpscan/issues/1266
#	sed -i "s|'activesupport', '~> 5.1'|'activesupport'|g" wpscan.gemspec
#	sed -i -e '/activesupport/,/^-/ s:^:#:' ../metadata || die
	sed -i -e '/s.add_development_dependency/d' wpscan.gemspec
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
