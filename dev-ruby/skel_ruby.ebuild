# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION=""
HOMEPAGE=""

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE=""
SLOT="0"

ruby_add_rdepend "
	dev-ruby/xyz
"
