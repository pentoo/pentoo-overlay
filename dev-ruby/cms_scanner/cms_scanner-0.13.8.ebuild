# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"
RUBY_FAKEGEM_EXTRAINSTALL="app"

inherit ruby-fakegem

DESCRIPTION="Framework to provide an easy way to implement CMS Scanners"
HOMEPAGE="https://github.com/wpscanteam/CMSScanner"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	=dev-ruby/get_process_mem-0.2*
	>=dev-ruby/nokogiri-1.11.4 <dev-ruby/nokogiri-1.14.0
	>=dev-ruby/opt_parse_validator-1.9.5
	>=dev-ruby/public_suffix-4.0.3:4
	>=dev-ruby/ruby-progressbar-1.10 <dev-ruby/ruby-progressbar-1.12
	dev-ruby/typhoeus:1
	>=dev-ruby/ethon-0.14 <dev-ruby/ethon-0.16
	=dev-ruby/xmlrpc-0*
	=dev-ruby/yajl-ruby-1.4*

	=dev-ruby/sys-proctable-1.2*
"

each_ruby_prepare() {
	#relax deps
	sed -i -e '/typhoeus/,/Gem::Dependency/ s:~>:>=:' ../metadata || die
}
