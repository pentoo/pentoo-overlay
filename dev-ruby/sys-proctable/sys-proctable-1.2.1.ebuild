# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby22 ruby23 ruby24"
inherit ruby-fakegem

DESCRIPTION="An interface for providing process table information"
HOMEPAGE="http://rubygems.org/gems/sys-proctable"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/ffi"
