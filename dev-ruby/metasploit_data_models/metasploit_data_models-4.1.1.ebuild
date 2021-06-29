# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26"

inherit ruby-fakegem

RUBY_FAKEGEM_EXTRAINSTALL="app config db script spec"
RUBY_FAKEGEM_GEMSPEC="${PN}".gemspec
DESCRIPTION="The database layer for Metasploit"
HOMEPAGE="https://github.com/rapid7/metasploit_data_models"
SRC_URI="https://rubygems.org/gems/${P}.gem"

LICENSE="BSD"
SLOT="$(ver_cut 1-2)"
#FIXME: Gentoo's recog is not arm64 ready
KEYWORDS="~amd64 ~x86"
RESTRICT=test
#IUSE="development test"
IUSE=""

RDEPEND="${RDEPEND} !dev-ruby/metasploit_data_models:0"

ruby_add_rdepend "
		>=dev-ruby/activerecord-5.2.2:5.2[postgres]
		>=dev-ruby/activesupport-5.2.2:5.2
		dev-ruby/arel-helpers
		dev-ruby/metasploit-concern
		>=dev-ruby/metasploit-model-3.1.0
		dev-ruby/pg:*
		>=dev-ruby/railties-5.2.2:5.2
		>=dev-ruby/recog-2.0.0:*"

ruby_add_bdepend "dev-ruby/bundler:2"

all_ruby_prepare() {
	[ -f Gemfile.lock ] && rm Gemfile.lock
	#if ! use development; then
		sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
		sed -i -e "/s.add_development_dependency/d" "${PN}".gemspec || die
	#fi
	#if ! use test; then
		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	#fi
	#if ! use test && ! use development; then
		sed -i -e "/^group :development, :test do/,/^end$/d" Gemfile || die
	#fi
	#use the stable version of pg
	sed -i "s/'pg', \"0.20.0\"/'pg', '0.21.0'/" metasploit_data_models.gemspec || die
}

each_ruby_prepare() {
	if [ -f Gemfile ]
	then
		GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		GEM_HOME="${T}" BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}

all_ruby_install() {
	ruby_fakegem_binwrapper mdm_console mdm_console-${SLOT}
}
