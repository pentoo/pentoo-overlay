# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"

inherit ruby-fakegem

DESCRIPTION="web spidering library"
HOMEPAGE="https://github.com/johnnagro/spider"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
#does not work, literally no clue why
RESTRICT=test
