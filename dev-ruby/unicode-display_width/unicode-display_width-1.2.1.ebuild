# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"

inherit multilib ruby-fakegem

DESCRIPTION="Determines the monospace display width of a string using EastAsianWidth.txt, Unicode"
HOMEPAGE="https://rubygems.org/gems/unicode-display_width"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
