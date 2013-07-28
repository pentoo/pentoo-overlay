# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2 eutils

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
EGIT_REPO_URI="git://github.com/wpscanteam/wpscan.git"
EGIT_COMMIT="1722025a2c19de55d89b942c7e0928216b264c8a"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"

DEPEND=""
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	>=dev-ruby/typhoeus-0.6.3
	dev-ruby/nokogiri
	dev-ruby/json
	dev-ruby/terminal-table
	>=dev-ruby/ruby-progressbar-1.1.0
	>=dev-ruby/webmock-1.9.3
	dev-ruby/simplecov
	dev-ruby/rspec"

src_prepare() {
	rm -r .git .gitignore .rspec README.md
	sed -i "/require 'bundler\/setup'/d" lib/environment.rb
	#dev-lang/ruby might need the "hardened" flag to enforce the following:
	if use hardened; then
		paxctl -v /usr/bin/ruby19 2>/dev/null | grep MPROTECT | grep disabled || ewarn '!!! Some dependencies such as typhoeus may only work if ruby19 has MPROTECT flag disabled\n  You can disable it running paxctl -m /usr/bin/ruby19'
	fi
}

src_install() {
	dodoc README CREDITS
	rm README CREDITS
	insinto /usr/$(get_libdir)/${PN}
	doins -r *
	dobin "${FILESDIR}"/wpscan
	dobin "${FILESDIR}"/wpstools
}
