# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2 eutils

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
EGIT_REPO_URI="git://github.com/wpscanteam/wpscan.git"
EGIT_COMMIT="ebfe2ef08df9d87e94f0a1a87ea88e0fc896ab78"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"

DEPEND=""
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	dev-ruby/ruby-progressbar
	~dev-ruby/ethon-0.5.10
	dev-ruby/mime-types
	dev-ruby/simplecov
	dev-ruby/terminal-table
	~dev-ruby/typhoeus-0.6.2
	dev-ruby/rspec
	dev-ruby/nokogiri
	dev-ruby/json
	>=dev-ruby/webmock-1.9.3
"
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
