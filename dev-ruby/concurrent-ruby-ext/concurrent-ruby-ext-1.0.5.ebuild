# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"
inherit ruby-fakegem

DESCRIPTION="C extensions to optimize the concurrent-ruby gem when running under MRI"
HOMEPAGE="http://www.concurrent-ruby.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_bdepend ">=dev-ruby/concurrent-ruby-0.8.0"
