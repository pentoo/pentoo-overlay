# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="A hexadecimal widget using gtk2, inspired by GHex"
HOMEPAGE="https://github.com/gdelugre/ruby-gtkhex"
LICENSE="LGPL-3"
SLOT=0
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/ruby-gtk2"
