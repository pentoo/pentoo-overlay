# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"
RUBY_FAKEGEM_EXTRAINSTALL="app bin spec"
RUBY_FAKEGEM_GEMSPEC="wpscan.gemspec"

inherit ruby-fakegem

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
SRC_URI="https://github.com/wpscanteam/wpscan/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

ruby_add_bdepend "dev-ruby/bundler:2"
ruby_add_rdepend "
	>=dev-ruby/cms_scanner-0.13.6"

each_ruby_prepare() {
#https://github.com/wpscanteam/wpscan/issues/1266
#	sed -i "s|'activesupport', '~> 5.1'|'activesupport'|g" wpscan.gemspec
#	sed -i -e '/activesupport/,/^-/ s:^:#:' ../metadata || die
	sed -i -e '/s.add_development_dependency/d' wpscan.gemspec || die
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
