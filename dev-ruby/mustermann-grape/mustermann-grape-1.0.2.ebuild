# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION="Adds Grape style patterns to Mustermman"
HOMEPAGE="https://github.com/ruby-grape/mustermann-grape"

KEYWORDS="amd64 ~arm64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	>=dev-ruby/mustermann-1.0.0
"
