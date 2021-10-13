# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="Alternative GNU Readline or Editline implementation by pure Ruby"
HOMEPAGE="https://github.com/ruby/reline/"

KEYWORDS="amd64 arm64 x86"
LICENSE="Ruby"
SLOT="0"

ruby_add_rdepend "
	dev-ruby/io-console
"
