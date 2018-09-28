# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24"
#RUBY_FAKEGEM_GEMSPEC="cms_scanner.gemspec"
#RUBY_FAKEGEM_REQUIRE_PATHS="app"
RUBY_FAKEGEM_EXTRAINSTALL="app"

inherit ruby-fakegem

DESCRIPTION="Framework to provide an easy way to implement CMS Scanners"
HOMEPAGE="https://github.com/wpscanteam/CMSScanner"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_rdepend "dev-ruby/activesupport:5.2
	>=dev-ruby/addressable-2.5.0
	>=dev-ruby/nokogiri-1.8.0
	>=dev-ruby/opt_parse_validator-0.0.16.2
	>=dev-ruby/public_suffix-3.0.0
	>=dev-ruby/ruby-progressbar-1.10.0
	dev-ruby/typhoeus:1
	>=dev-ruby/xmlrpc-0.3.0
	>=dev-ruby/yajl-ruby-1.4.1"

#all_ruby_prepare() {
#	epatch "${FILESDIR}/0.0.40_spec.patch"
#	sed -i -e 's/git ls-files -z/find . -type f -print/' ${RUBY_FAKEGEM_GEMSPEC} || die
#	sed -i -e 's/git ls-files -z/find . -print0/' ${RUBY_FAKEGEM_GEMSPEC} || die
#}
