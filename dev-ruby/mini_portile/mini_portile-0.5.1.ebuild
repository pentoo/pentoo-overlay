# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
USE_RUBY="ruby18 ruby19"

inherit multilib ruby-fakegem

DESCRIPTION="Simplified way to compile against dependency libraries without messing up your system"
HOMEPAGE="https://rubygems.org/gems/mini_portile"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~x86"
