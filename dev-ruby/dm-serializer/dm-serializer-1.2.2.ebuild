# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="DataMapper plugin for serializing Resources and Collections"
HOMEPAGE="https://github.com/datamapper/dm-serializer"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

#ruby_add_bdepend "doc? ( dev-ruby/yard )"
ruby_add_bdepend "dev-ruby/multi_json
				dev-ruby/fastercsv"
				#test? ( dev-ruby/rspec )"

ruby_add_rdepend ">=dev-ruby/dm-core-1.2.0"
