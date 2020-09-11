# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="Core libraries required for the Ruby Exploitation (Rex) Suite"
HOMEPAGE="https://github.com/rapid7/rex-core"

LICENSE="BSD-3"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

# doesn't seem to actually run any tests, fails without disabling
RESTRICT=test
