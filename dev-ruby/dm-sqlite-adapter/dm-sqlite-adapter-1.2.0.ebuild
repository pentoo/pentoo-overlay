# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23 ruby24"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Sqlite3 Adapter for DataMapper"
HOMEPAGE="http://github.com/datamapper/dm-sqlite-adapter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Tests require dm-do-adapter's spec directory installed.
RESTRICT="test"

ruby_add_bdepend "test? ( >=dev-ruby/jeweler-1.6.4
	>=dev-ruby/rspec-1.3.2 )"

ruby_add_rdepend ">=dev-ruby/do_sqlite3-0.10.6
	>=dev-ruby/dm-do-adapter-1.2.0"

all_ruby_prepare() {
	sed -i -e '/check_dependencies/d' tasks/spec.rake || die
}
