# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="A plugin system based on rubygems that uses dependencies only"
HOMEPAGE="https://github.com/genki/gem_plugin"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
