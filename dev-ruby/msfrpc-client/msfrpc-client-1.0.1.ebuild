# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

USE_RUBY="ruby21 ruby23"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="This gem provides a Ruby client API to access the Rapid7 Metasploit Pro RPC service"
HOMEPAGE="http://rubygems.org/gems/msfrpc-client"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Tests fail with load errors, possibly due to unfulfilled
# dependencies. Needs ot be investigated before moved to main tree.
RESTRICT="test"

#ruby_add_bdepend "doc? ( dev-ruby/yard )"
#ruby_add_bdepend "test? ( dev-ruby/rspec )"

ruby_add_rdepend ">=dev-ruby/librex-0.0.32 >=dev-ruby/msgpack-0.4.5"
