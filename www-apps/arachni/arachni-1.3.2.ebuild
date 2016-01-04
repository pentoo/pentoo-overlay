# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby21"

inherit eutils ruby-ng

DESCRIPTION="Arachni is a feature-full web application scanner"
HOMEPAGE="http://arachni-scanner.com/"
SRC_URI="https://github.com/Arachni/arachni/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libxslt
	dev-libs/openssl
	dev-libs/libxml2
	dev-libs/mpfr
	dev-libs/libyaml
"
ruby_add_rdepend "
	=dev-ruby/addressable-2.3* >=dev-ruby/addressable-2.3.6
	>=dev-ruby/arachni-rpc-0.2.1.2
	=dev-ruby/awesome_print-1.2*
	dev-ruby/bundler
	>=dev-ruby/childprocess-0.5.3
	>=dev-ruby/coderay-1.1.0
	>=dev-ruby/kramdown-1.4.1
	=dev-ruby/loofah-2.0*
	>=dev-ruby/msgpack-0.5.8
	=dev-ruby/nokogiri-1.6* >=dev-ruby/nokogiri-1.6.5
	=dev-ruby/oj-2.12*
	dev-ruby/oj_mimic_json
	>=dev-ruby/pony-1.8
	dev-ruby/rack:*
	>=dev-ruby/rb-readline-0.5.1
	dev-ruby/rubyzip:1
	>=dev-ruby/terminal-table-1.4.5
	dev-ruby/typhoeus:0.6
	>=dev-ruby/watir-webdriver-0.6.9
"

src_prepare() {
	pushd "all"
	epatch "${FILESDIR}/${PV}-config.patch"
	epatch "${FILESDIR}/${PV}-easierdep.patch"
	popd
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/all/${P}/* "${ED}"/usr/$(get_libdir)/${PN}/ || die "Copy files failed"

	dosym /usr/$(get_libdir)/arachni/bin/arachni /usr/bin/arachni
	dosym /usr/$(get_libdir)/arachni/bin/arachni_console /usr/bin/arachni_console
}
