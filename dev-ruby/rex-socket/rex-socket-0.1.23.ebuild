# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="The Ruby Exploitation (Rex) Socket Abstraction Library"
HOMEPAGE="https://github.com/rapid7/rex-socket"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

# doesn't seem to actually run any tests, fails without disabling
RESTRICT=test

ruby_add_bdepend "dev-ruby/rex-core"
