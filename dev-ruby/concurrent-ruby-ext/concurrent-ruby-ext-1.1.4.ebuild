# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24 ruby25"
inherit ruby-fakegem

DESCRIPTION="C extensions to optimize the concurrent-ruby gem when running under MRI"
HOMEPAGE="http://www.concurrent-ruby.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_bdepend ">=dev-ruby/concurrent-ruby-1.1.3"
