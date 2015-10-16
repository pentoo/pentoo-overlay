# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

MY_V="0.4.1.1"
MY_P=${P}-${MY_V}

DESCRIPTION="Arachni is a feature-full web application scanner"
HOMEPAGE="http://arachni-scanner.com/"
SRC_URI="https://github.com/Arachni/arachni/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND=">=dev-lang/ruby-1.9.2
	dev-ruby/rubygems
	dev-ruby/diff-lcs
	dev-ruby/json
	dev-ruby/yard
	dev-ruby/redcarpet
	dev-libs/libxslt
	dev-libs/openssl
	dev-libs/libxml2
	dev-libs/mpfr
	dev-libs/libyaml
	virtual/ruby-ffi
	=dev-ruby/addressable-2.3* >=dev-ruby/addressable-2.3.2
	dev-ruby/awesome_print
	>=dev-ruby/nokogiri-1.5.7_rc1
	>=dev-ruby/terminal-table-1.4.2

	=dev-ruby/arachni-rpc-em-0.2
	=dev-ruby/typhoeus-0.3* >=dev-ruby/typhoeus-0.3.3
	dev-ruby/pony
	dev-ruby/rb-readline
	>=dev-ruby/sys-proctable-0.9.1
	dev-ruby/highline
	=dev-ruby/sinatra-1.3* >=dev-ruby/sinatra-1.3.2
	=dev-ruby/sinatra-contrib-1.3* >=dev-ruby/sinatra-contrib-1.3.1

	dev-ruby/bundler
	dev-ruby/rspec
	www-servers/thin

	test? ( dev-ruby/rspec
		dev-ruby/rake
	)
"
#FIXME: dev-ruby/typhoeus:0.3 must be enforced. bundler is the only solution for now
#src_prepare() {
#	epatch "${FILESDIR}/${PV}-unbundler.patch"
#}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${ED}"/usr/$(get_libdir)/${PN}/ || die "Copy files failed"
	dosbin "${FILESDIR}"/${PN}
}
