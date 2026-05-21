# Copyright 1999-2027 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Get memory usage of a process"
HOMEPAGE="https://github.com/schneems/get_process_mem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#/var/tmp/portage/dev-ruby/get_process_mem-0.2.7/work/ruby32/get_process_mem-0.2.7/test/test_helper.rb:1:in `<top (required)>': uninitialized constant Bundler (NameError)
RESTRICT="test"

ruby_add_rdepend "dev-ruby/ffi"

#development: dev-ruby/sys-proctable"
