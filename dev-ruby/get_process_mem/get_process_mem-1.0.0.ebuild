# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"
# test/test_helper.rb:1:in `<top (required)>': uninitialized constant Bundler (NameError)
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Get memory usage of a process"
HOMEPAGE="https://github.com/schneems/get_process_mem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

ruby_add_rdepend "dev-ruby/bigdecimal
	dev-ruby/ffi"

#development: dev-ruby/sys-proctable"
