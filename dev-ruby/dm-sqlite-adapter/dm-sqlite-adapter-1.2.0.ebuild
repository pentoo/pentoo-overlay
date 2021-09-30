# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Sqlite3 Adapter for DataMapper"
HOMEPAGE="https://github.com/datamapper/dm-sqlite-adapter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Tests require dm-do-adapter's spec directory installed.
RESTRICT="test"

ruby_add_bdepend "test? ( >=dev-ruby/rspec-1.3.2 )"

ruby_add_rdepend ">=dev-ruby/do_sqlite3-0.10.6
	>=dev-ruby/dm-do-adapter-1.2.0"

all_ruby_prepare() {
	sed -i -e '/check_dependencies/d' tasks/spec.rake || die
}
