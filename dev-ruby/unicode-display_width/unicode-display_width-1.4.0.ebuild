# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

inherit multilib ruby-fakegem

DESCRIPTION="Determines the monospace display width of a string"
HOMEPAGE="https://rubygems.org/gems/unicode-display_width"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
