# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="Provides a Formatter for the Grape API DSL"
HOMEPAGE="https://github.com/ruby-grape/grape-active_model_serializers"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	>=dev-ruby/active_model_serializers-0.10.0
	>=dev-ruby/grape-0.8.0
"
