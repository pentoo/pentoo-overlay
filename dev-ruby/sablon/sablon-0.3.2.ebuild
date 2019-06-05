# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"
RUBY_FAKEGEM_BINDIR="exe"

inherit ruby-fakegem

DESCRIPTION="Document template processor of Microsoft XML format (docx)"
HOMEPAGE="https://github.com/senny/sablon"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/nokogiri-1.6.0
	>=dev-ruby/rubyzip-1.1.1
"
