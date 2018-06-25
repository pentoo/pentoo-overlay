# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="JSON implementation in pure Ruby"
HOMEPAGE="http://flori.github.com/json"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

RESTRICT="test"

#ruby_add_bdepend "doc? ( dev-ruby/yard )"
#ruby_add_bdepend "dev-ruby/multi_json
#				dev-ruby/fastercsv"
				#test? ( dev-ruby/rspec )"

#ruby_add_rdepend ">=dev-ruby/dm-core-1.2.0"
