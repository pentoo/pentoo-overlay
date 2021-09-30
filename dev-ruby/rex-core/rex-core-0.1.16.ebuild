# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

inherit ruby-fakegem

DESCRIPTION="Core libraries required for the Ruby Exploitation (Rex) Suite"
HOMEPAGE="https://github.com/rapid7/rex-core"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="BSD"
SLOT="0"

# doesn't seem to actually run any tests
RESTRICT=test
