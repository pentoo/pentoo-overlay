# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/metasploit_data_models/metasploit_data_models-0.17.0.ebuild,v 1.3 2014/07/09 21:13:54 zerochaos Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-fakegem

DESCRIPTION="A tool to intercept and modify DNS requests"
HOMEPAGE="https://github.com/ioquatix/rubydns"
#SRC_URI="https://rubygems.org/gems/${P}.gem"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="unknown/BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/file-tail-1.0.5
	>=dev-ruby/ruby2ruby-1.2.5
	>=dev-ruby/ruby_parser-2.0.5
	dev-ruby/sexp_processor:0"

#sexp_processor >= 3.0.5
