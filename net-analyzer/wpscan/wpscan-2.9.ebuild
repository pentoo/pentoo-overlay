# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

USE_RUBY="ruby19 ruby21 ruby22"

inherit eutils ruby-ng

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
SRC_URI="https://github.com/wpscanteam/wpscan/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

ruby_add_rdepend "dev-ruby/rubygems
	>=dev-ruby/typhoeus-0.6.8
	dev-ruby/nokogiri
	>dev-ruby/yajl-ruby-1.2.0
	>=dev-ruby/terminal-table-1.4.5
	>=dev-ruby/ruby-progressbar-1.6.0
	dev-ruby/addressable"

ruby_add_bdepend "
	test? (
		>=dev-ruby/webmock-1.9.3
		dev-ruby/simplecov
		dev-ruby/rspec
	)"

S="${WORKDIR}"/all/${P}

src_prepare() {
	#https://github.com/wpscanteam/wpscan/issues/706
	epatch "${FILESDIR}/${PN}"-2.5.1_regular_user.patch
	rm -r README.md
	sed -i "/require 'bundler\/setup'/d" lib/environment.rb

	unpack ./data.zip
	rm ./data.zip
}

src_install() {
	dodoc CHANGELOG.md CREDITS
	rm CHANGELOG.md CREDITS
	insinto /usr/$(get_libdir)/${PN}
	doins -r *
	dobin "${FILESDIR}"/wpscan
	dobin "${FILESDIR}"/wpstools
}
