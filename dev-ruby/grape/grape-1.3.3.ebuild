# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION=""
HOMEPAGE=""

KEYWORDS="~amd64 ~x86"
LICENSE=""
SLOT="0"

ruby_add_rdepend "
	dev-ruby/activesupport
	dev-ruby/builder
	>=dev-ruby/dry-types-1.1
	=dev-ruby/mustermann-grape-1.0*
	>=dev-ruby/rack-1.3.0
	dev-ruby/rack-accept
"
