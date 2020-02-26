# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="An Object/Relational Mapper for Ruby"
HOMEPAGE="http://datamapper.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Requires do_sqlite3 which we do not have packaged yet.  In 1.0.0
# tests fail altogether. Should be fixed before moving to main tree.
RESTRICT="test"

ruby_add_bdepend "test? ( >=dev-ruby/rake-10.0.3 >=dev-ruby/rspec-1.3.2 )"

ruby_add_rdepend "
	>=dev-ruby/addressable-2.3"
