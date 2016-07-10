# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21"

inherit ruby-fakegem

DESCRIPTION="Protect attributes from mass assignment"
HOMEPAGE="https://github.com/rails/protected_attributes"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( dev-ruby/actionpack:4.0 dev-ruby/actionpack:4.1 dev-ruby/actionpack:4.2 )
	|| ( dev-ruby/activerecord:4.0 dev-ruby/activerecord:4.1 dev-ruby/activerecord:4.2 )
	|| ( dev-ruby/railties:4.0 dev-ruby/railties:4.1 dev-ruby/railties:4.2 )
	dev-ruby/sqlite3
	dev-ruby/mocha:=
"
