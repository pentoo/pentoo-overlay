# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24 ruby25"
RUBY_FAKEGEM_EXTRAINSTALL="app bin spec"

inherit ruby-fakegem

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
SRC_URI="https://github.com/wpscanteam/wpscan/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test memprof"

ruby_add_bdepend "dev-ruby/bundler"
ruby_add_rdepend ">=dev-ruby/cms_scanner-0.6.0
	>=dev-ruby/addressable-2.5.0
	dev-ruby/activesupport:*
	>=dev-ruby/yajl-ruby-1.3.0
	memprof? ( dev-ruby/memory_profiler )
"

each_ruby_prepare() {
#https://github.com/wpscanteam/wpscan/issues/1266
#	sed -i "s|'activesupport', '~> 5.1'|'activesupport'|g" wpscan.gemspec
#	sed -i -e '/activesupport/,/^-/ s:^:#:' ../metadata || die
	sed -i -e '/s.add_development_dependency/d' wpscan.gemspec
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
