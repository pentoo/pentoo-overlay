# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="A cross-platform Ruby interface for gathering process information"
HOMEPAGE="https://github.com/djberg96/sys-proctable"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"

ruby_add_rdepend "dev-ruby/ffi"
