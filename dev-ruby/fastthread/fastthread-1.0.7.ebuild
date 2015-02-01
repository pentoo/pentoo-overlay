# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="Optimized replacement for thread.rb primitives"
HOMEPAGE="https://github.com/mental/fastthread"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
