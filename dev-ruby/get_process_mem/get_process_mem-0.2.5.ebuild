# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

inherit ruby-fakegem

DESCRIPTION="Get memory usage of a process"
HOMEPAGE="https://github.com/schneems/get_process_mem"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "dev-ruby/ffi
	dev-ruby/sys-proctable"
