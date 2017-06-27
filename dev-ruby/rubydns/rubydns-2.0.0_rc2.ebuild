# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23 ruby24"
RUBY_FAKEGEM_VERSION="2.0.0.pre.rc2"

inherit ruby-fakegem

DESCRIPTION="A tool to intercept and modify DNS requests"
HOMEPAGE="https://github.com/ioquatix/rubydns"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/async-dns-0.12 =dev-ruby/async-dns-0*"
