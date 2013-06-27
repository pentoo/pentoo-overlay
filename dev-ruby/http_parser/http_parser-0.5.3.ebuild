# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Ruby bindings to http-parser.java"
HOMEPAGE="https://github.com/tmm1/http_parser.rb"
SRC_URI="http://rubygems.org/downloads/http_parser.rb-0.5.3.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Tests fail with load errors, possibly due to unfulfilled
# dependencies. Needs ot be investigated before moved to main tree.
RESTRICT="test"

#ruby_add_bdepend "doc? ( dev-ruby/yard )"
#ruby_add_bdepend "test? ( dev-ruby/rspec )"

#need to verify
ruby_add_rdepend ">=dev-ruby/json-1.4.6"
