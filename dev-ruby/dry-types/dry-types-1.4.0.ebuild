# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="collection of next-generation Ruby libraries"
HOMEPAGE="https://dry-rb.org/"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	=dev-ruby/concurrent-ruby-1*
	=dev-ruby/dry-container-0*
	>=dev-ruby/dry-core-0.4.4
	=dev-ruby/dry-equalizer-0*
	>=dev-ruby/dry-inflector-0.1.2
	>=dev-ruby/dry-logic-1.0.2
"
