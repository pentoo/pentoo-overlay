# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby30 ruby31 ruby32"
inherit ruby-fakegem

DESCRIPTION="Automatic strong parameter detection with Hashie and Forbidden Attributes"
HOMEPAGE="https://rubygems.org/gems/hashie-forbidden_attributes"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/hashie"
