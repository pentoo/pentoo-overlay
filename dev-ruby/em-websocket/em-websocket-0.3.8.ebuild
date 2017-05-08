# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

USE_RUBY="ruby21 ruby23"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"
#broken, not sure why
RESTRICT="test"

inherit ruby-fakegem

DESCRIPTION="EventMachine based WebSocket server"
HOMEPAGE="https://github.com/igrigorik/em-websocket"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Tests fail with load errors, possibly due to unfulfilled
# dependencies. Needs ot be investigated before moved to main tree.
#RESTRICT="test"

#ruby_add_bdepend "doc? ( dev-ruby/yard )"
#ruby_add_bdepend "test? ( dev-ruby/rspec )"

ruby_add_rdepend ">=dev-ruby/eventmachine-0.12.9 >=dev-ruby/addressable-2.1.1"
