# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

inherit multilib ruby-fakegem

DESCRIPTION="Enables many features of Ruby for earlier versions"
HOMEPAGE="https://rubygems.org/gems/backports"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
