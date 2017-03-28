# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

USE_RUBY="ruby21 ruby22"

inherit eutils ruby-ng

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
SRC_URI="https://github.com/wpscanteam/wpscan/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RUBY_DEPS="dev-ruby/rubygems
	dev-ruby/typhoeus:1
	>=dev-ruby/nokogiri-1.6.7.2
	>dev-ruby/yajl-ruby-1.2.0
	dev-ruby/addressable
	>=dev-ruby/terminal-table-1.6.0
	>=dev-ruby/ruby-progressbar-1.6.0
	>=dev-ruby/webmock-1.7.2:0
	dev-ruby/bundler
"

ruby_add_bdepend "${RUBY_DEPS}"
ruby_add_rdepend "${RUBY_DEPS}"

#	test? (
#		>=dev-ruby/webmock-1.9.3
#		dev-ruby/simplecov
#		dev-ruby/rspec
#	)"

each_ruby_prepare() {
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}

#src_prepare() {
all_ruby_prepare() {
	#https://github.com/wpscanteam/wpscan/issues/706
	epatch "${FILESDIR}/${PN}"-2.5.1_regular_user.patch
	rm -r README.md
#	sed -i "/require 'bundler\/setup'/d" lib/environment.rb

	if ! use test; then
		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	fi

	unpack ./data.zip
	rm ./data.zip
	rm -r ./dev

	default
}

#src_install() {
all_ruby_install() {
	dodoc CHANGELOG.md CREDITS
	rm CHANGELOG.md CREDITS
	insinto /usr/$(get_libdir)/${PN}
	doins -r *
	dobin "${FILESDIR}"/wpscan
	dobin "${FILESDIR}"/wpstools
}
