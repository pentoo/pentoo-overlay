# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Pure ruby PNG file manipulation & validation"
HOMEPAGE="https://github.com/zed-0xff/zpng"
SRC_URI="https://github.com/zed-0xff/zpng/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_rdepend "dev-ruby/rainbow"
ruby_add_bdepend "dev-ruby/bundler"
