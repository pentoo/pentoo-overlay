# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

inherit ruby-fakegem

DESCRIPTION="Get memory usage of a process"
HOMEPAGE="https://github.com/schneems/get_process_mem"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "dev-ruby/ffi"

#development: dev-ruby/sys-proctable"
