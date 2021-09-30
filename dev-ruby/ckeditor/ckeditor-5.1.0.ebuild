# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

inherit ruby-fakegem

DESCRIPTION="Ckeditor 4.x integration gem for rails"
HOMEPAGE="https://github.com/galetahub/ckeditor"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/orm_adapter"
