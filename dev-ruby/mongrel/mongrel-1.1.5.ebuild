# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby19"

inherit ruby-fakegem

MY_P=${P}.pre2

DESCRIPTION="A small fast HTTP library and server that runs Rails, Camping, Nitro and Iowa apps."
HOMEPAGE="http://mongrel.rubyforge.org/"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="unknown"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
KEYWORDS=""
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/daemons-1.0.3
	>=dev-ruby/cgi_multipart_eof_fix-2.4
	>=dev-ruby/fastthread-1.0.1
	>=dev-ruby/gem_plugin-0.2.3
"
