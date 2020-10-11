# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26"

inherit ruby-fakegem

DESCRIPTION="Extraction of the key_transform abilities of ActiveModelSerializers"
HOMEPAGE="https://github.com/NullVoxPopuli/case_transform"

KEYWORDS="amd64 ~arm64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	dev-ruby/activesupport:*
"
