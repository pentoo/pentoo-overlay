# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
USE_RUBY="ruby18 ruby19"
RUBY_FAKEGEM_VERSION="${PV}-universal-linux"

inherit ruby-fakegem

DESCRIPTION="An interface for providing process table information"
HOMEPAGE="http://rubygems.org/gems/sys-proctable"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend ">dev-ruby/mail-2.0"
