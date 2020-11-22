# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="Generate JSON in an object-oriented and convention-driven manner"
HOMEPAGE="https://github.com/rails-api/active_model_serializers"

KEYWORDS="amd64 ~arm64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	<dev-ruby/actionpack-6.1
	<dev-ruby/activemodel-6.1
	>=dev-ruby/case_transform-0.2
	<dev-ruby/jsonapi-renderer-0.3
"
