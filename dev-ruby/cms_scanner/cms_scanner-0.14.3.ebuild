# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"
RUBY_FAKEGEM_EXTRAINSTALL="app"

inherit ruby-fakegem

DESCRIPTION="Framework to provide an easy way to implement CMS Scanners"
HOMEPAGE="https://github.com/wpscanteam/CMSScanner"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "
	=dev-ruby/get_process_mem-0.2*
	>=dev-ruby/nokogiri-1.16
	>=dev-ruby/opt_parse_validator-1.10.0
	>=dev-ruby/public_suffix-4.0.3 <dev-ruby/public_suffix-6.1
	>=dev-ruby/ruby-progressbar-1.10 <dev-ruby/ruby-progressbar-1.14
	dev-ruby/typhoeus:1
	>=dev-ruby/ethon-0.14 <dev-ruby/ethon-0.17
	=dev-ruby/xmlrpc-0*
	=dev-ruby/yajl-ruby-1.4*

	=dev-ruby/sys-proctable-1.2*
"

#each_ruby_prepare() {
	#relax deps
#	sed -i -e '/typhoeus/,/Gem::Dependency/ s:~>:>=:' ../metadata || die
#	sed -i -e '/^  name: nokogiri/,/^[[:space:]]*$/s:1.14.0:1.16.0:' ../metadata || die
#	sed -i -e '/^  name: ruby-progressbar/,/^[[:space:]]*$/s:1.12:1.14:' ../metadata || die
#}
