# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

inherit ruby-fakegem
RUBY_FAKEGEM_BINWRAP=""

DESCRIPTION="IPAddr provides a set of methods to manipulate an IP address"
HOMEPAGE="https://github.com/ruby/ipaddr"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
