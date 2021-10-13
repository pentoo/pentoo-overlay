# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="suite of tools for analyzing executables to find specific chunks of code"
HOMEPAGE="https://rubygems.org/gems/rex-bin_tools"

LICENSE="BSD"

SLOT="0"
#metasm is not stable in Gentoo
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""
RESTRICT="test"

ruby_add_rdepend "dev-ruby/rex-arch
		dev-ruby/metasm
		dev-ruby/rex-core
		dev-ruby/rex-struct2
		dev-ruby/rex-text"

all_ruby_prepare() {
	sed -i '/bundler/d' Rakefile
}
