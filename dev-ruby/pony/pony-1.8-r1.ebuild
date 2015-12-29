# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21 ruby22"

inherit ruby-fakegem

DESCRIPTION="Send email in one command"
HOMEPAGE="http://rubygems.org/gems/pony"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

#>=dev-ruby/mail-2.0
ruby_add_rdepend " || ( dev-ruby/mail:2.6 dev-ruby/mail:2.5 )"
