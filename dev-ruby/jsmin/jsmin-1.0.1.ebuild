# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Ruby implementation of Douglas Crockford's JSMin JavaScript minifier"
HOMEPAGE="http://github.com/rgrove/jsmin/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Tests fail with load errors, possibly due to unfulfilled
# dependencies. Needs ot be investigated before moved to main tree.
RESTRICT="test"

#ruby_add_bdepend "doc? ( dev-ruby/yard )"
#ruby_add_bdepend "test? ( dev-ruby/rspec )"

#ruby_add_rdepend ""
