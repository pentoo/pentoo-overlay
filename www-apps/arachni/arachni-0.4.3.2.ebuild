# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

MY_V="0.4.1.1"
MY_P=${P}-${MY_V}

DESCRIPTION="Arachni is a feature-full web application scanner"
HOMEPAGE="http://arachni-scanner.com/"
SRC_URI="https://github.com/Arachni/arachni/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/ruby-1.9.2
	dev-ruby/rubygems
	dev-ruby/json
	dev-ruby/rspec
	dev-ruby/yard
	dev-ruby/redcarpet
	dev-libs/libxslt
	dev-libs/openssl
	dev-libs/libxml2
	dev-libs/mpfr
	dev-libs/libyaml

	=dev-ruby/addressable-2.3*
	dev-ruby/awesome_print
	>=dev-ruby/nokogiri-1.5.7_rc1
	>=dev-ruby/terminal-table-1.4.2

	=dev-ruby/arachni-rpc-em-0.2
	=dev-ruby/typhoeus-0.3* >=dev-ruby/typhoeus-0.3.3
	=dev-ruby/addressable-2.3* >=dev-ruby/addressable-2.3.2
	dev-ruby/pony
	dev-ruby/rb-readline
	>=dev-ruby/sys-proctable-0.9.1
	dev-ruby/highline
"

#    s.add_development_dependency 'bundler'
#    s.add_development_dependency 'rake'
#    s.add_development_dependency 'rspec'
#    s.add_development_dependency 'thin'
#    s.add_development_dependency 'sinatra',         '~> 1.3.2'
#    s.add_development_dependency 'sinatra-contrib', '~> 1.3.1'
#	=dev-ruby/sinatra-1.3* >=dev-ruby/sinatra-1.3.2
#	=dev-ruby/sinatra-contrib-1.3* >=dev-ruby/sinatra-contrib-1.3.1


##   dev-ruby/rake-10.1.0

#libffi4
#libxslt
#libcurl4 (< 4.29.0)



src_prepare() {
	epatch "${FILESDIR}/${PV}-unbundler.patch"
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${ED}"/usr/$(get_libdir)/${PN}/ || die "Copy files failed"
	dosbin "${FILESDIR}"/${PN}
}
