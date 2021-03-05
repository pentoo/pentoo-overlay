# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26"

inherit ruby-fakegem
RUBY_FAKEGEM_EXTRAINSTALL="app config script spec"

DESCRIPTION="Common code, such as validators and mixins"
HOMEPAGE="https://github.com/rapid7/metasploit-model"
SRC_URI="https://rubygems.org/gems/${P}.gem"

LICENSE="BSD"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 ~arm64 ~x86"
#IUSE="development test"
RESTRICT=test
IUSE=""

RDEPEND="${RDEPEND} !dev-ruby/metasploit-model:0"

ruby_add_rdepend ">=dev-ruby/railties-5.2.2:5.2
			>=dev-ruby/activesupport-5.2.2:5.2
			>=dev-ruby/activemodel-5.2.2:5.2"
ruby_add_bdepend "dev-ruby/bundler:2"

all_ruby_prepare() {
	[ -f Gemfile.lock ] && rm Gemfile.lock
	#For now, we don't support development or testing at all
	#if ! use development; then
		sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
		sed -i -e "/s.add_development_dependency/d" "${PN}".gemspec || die
		sed -i -e "/spec.add_development_dependency/d" "${PN}".gemspec || die
	#fi
	#if ! use test; then
		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	#fi
	#if ! use test && ! use development; then
		sed -i -e "/^group :development, :test do/,/^end$/d" Gemfile || die
	#fi
}

each_ruby_prepare() {
	if [ -f Gemfile ]
	then
		GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}
