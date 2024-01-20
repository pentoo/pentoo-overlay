# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A Struct that can read/write itself from/to IO-like objects"
HOMEPAGE="https://github.com/zed-0xff/iostruct"
SRC_URI="https://github.com/zed-0xff/iostruct/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

ruby_add_bdepend "dev-ruby/bundler
	dev-ruby/rake"
