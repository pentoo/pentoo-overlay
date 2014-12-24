# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-fakegem

DESCRIPTION="A Javascript code obfuscator"
HOMEPAGE="https://github.com/rapid7/jsobfu"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "=dev-ruby/rkelly-remix-0.0.6"
