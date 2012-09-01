# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2 eutils

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
EGIT_REPO_URI="git://github.com/wpscanteam/wpscan.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	dev-ruby/mime-types
	dev-ruby/typhoeus
	dev-ruby/nokogiri
	dev-ruby/json"

src_prepare() {
	rm -r .git ./cache .gitignore .rspec README.md
}

src_install() {
	dodoc README CREDITS
	rm README CREDITS
	insinto /usr/$(get_libdir)/${PN}
	doins -r *

	dobin "${FILESDIR}"/wpscan
#	dosym wpstools.rb
}
