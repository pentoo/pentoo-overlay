# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"
inherit ruby-ng

DESCRIPTION="A custom word list generator"
HOMEPAGE="http://www.digininja.org/projects/cewl.php"
SRC_URI="https://github.com/digininja/CeWL/archive/5.2.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "dev-ruby/bundler"

ruby_add_rdepend "dev-ruby/hpricot
		 dev-ruby/http_configuration
		 dev-ruby/spider
		 dev-ruby/mime-types
		 dev-ruby/rubyzip
		 dev-ruby/mini_exiftool"

all_ruby_prepare() {
	sed -i "s|require './cewl_lib'|require 'cewl_lib'|g" CeWL-${PV}/cewl.rb
	sed -i "s|require 'mime'|require 'mime/types'|g" CeWL-${PV}/cewl_lib.rb
}

each_ruby_install() {
	doruby CeWL-${PV}/cewl_lib.rb CeWL-${PV}/fab.rb
}

all_ruby_install() {
	dodoc CeWL-${PV}/README
	newbin CeWL-${PV}/cewl.rb cewl
}

each_ruby_prepare() {
        if [ -f Gemfile ]
        then
                BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
                BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
        fi
}

