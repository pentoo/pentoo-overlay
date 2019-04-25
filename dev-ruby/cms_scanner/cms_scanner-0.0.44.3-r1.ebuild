# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"
RUBY_FAKEGEM_EXTRAINSTALL="app"

inherit ruby-fakegem

DESCRIPTION="Framework to provide an easy way to implement CMS Scanners"
HOMEPAGE="https://github.com/wpscanteam/CMSScanner"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_rdepend "
	dev-ruby/activesupport:*
	>=dev-ruby/addressable-2.5.0
	>=dev-ruby/nokogiri-1.10.0
	=dev-ruby/opt_parse_validator-0.0.17*
	>=dev-ruby/public_suffix-3.0.0
	>=dev-ruby/ruby-progressbar-1.10.0
	dev-ruby/typhoeus:1
	=dev-ruby/xmlrpc-0.3*
	>=dev-ruby/yajl-ruby-1.4.1"

each_ruby_prepare() {
	#relax 5.1 to any
	sed -i -e '/activesupport/,/^-/ s:^:#:' ../metadata || die
}
