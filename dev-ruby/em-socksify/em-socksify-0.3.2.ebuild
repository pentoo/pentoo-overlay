# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#eventmachine does not support ruby27 yet
USE_RUBY="ruby25 ruby26"

inherit ruby-fakegem

DESCRIPTION="Transparent proxy support for any EventMachine protocol"
HOMEPAGE="https://github.com/igrigorik/em-socksify"

KEYWORDS="amd64 ~arm64 x86"
LICENSE=""
SLOT="0"

ruby_add_rdepend "dev-ruby/eventmachine"
