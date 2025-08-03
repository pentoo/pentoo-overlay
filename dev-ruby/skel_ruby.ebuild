# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION=""
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

ruby_add_rdepend "
	dev-ruby/xyz
"
