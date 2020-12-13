# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Ruby Exploitation(Rex) Library for building ROP chains"
HOMEPAGE="https://rubygems.org/gems/rex-rop_builder"

LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""
RESTRICT="test"

ruby_add_rdepend "dev-ruby/metasm
		dev-ruby/rex-core
		dev-ruby/rex-text"

all_ruby_prepare() {
	sed -i '/bundler/d' Rakefile
}
