# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby18 ruby19"
inherit ruby-ng

DESCRIPTION="A custom word list generator"
HOMEPAGE="http://www.digininja.org/projects/cewl.php"
SRC_URI="http://www.digininja.org/files/${PN}_${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-ruby/hpricot
		 dev-ruby/http_configuration
		 dev-ruby/spider
		 dev-ruby/mime-types
		 dev-ruby/rubyzip
		 dev-ruby/mini_exiftool"

all_ruby_prepare() {
	sed -i "s|require './cewl_lib'|require 'cewl_lib'|g" cewl/cewl.rb
	sed -i 's|require "zip"|require "zip/zip"|g' cewl/cewl_lib.rb
	sed -i "s|require 'mime'|require 'mime/types'|g" cewl/cewl_lib.rb
}

each_ruby_install() {
	doruby cewl/cewl_lib.rb cewl/fab.rb
}

all_ruby_install() {
	dodoc cewl/README
	newbin cewl/cewl.rb cewl
}
