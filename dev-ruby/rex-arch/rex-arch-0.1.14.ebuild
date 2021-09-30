# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="architecture specific information for Rex"
HOMEPAGE="https://rubygems.org/gems/rex-arch"

LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

ruby_add_bdepend "dev-ruby/rex-text"
