# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"

inherit ruby-fakegem

DESCRIPTION=""
HOMEPAGE=""

KEYWORDS="~amd64 ~arm64 ~x86"
LICENSE=""
SLOT="0"

ruby_add_rdepend "
	dev-ruby/xyz
"
