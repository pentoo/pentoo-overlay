# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"
inherit ruby-ng

DESCRIPTION="A custom word list generator"
HOMEPAGE="http://www.digininja.org/projects/cewl.php"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/digininja/CeWL.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/all/CeWL-${PV}"
else
	SRC_URI="https://github.com/digininja/CeWL/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""
MY_P="CeWL-${PV}"

ruby_add_bdepend "dev-ruby/bundler:2"

ruby_add_rdepend "dev-ruby/nokogiri
		dev-ruby/spider
		dev-ruby/mini_exiftool
		dev-ruby/rubyzip:*
		dev-ruby/mime-types:*"

all_ruby_prepare() {
	sed -i "s|require './cewl_lib'|require 'cewl_lib'|g" ${MY_P}/cewl.rb || die
	sed -i "s|require_relative 'cewl_lib'|require 'cewl_lib'|g" ${MY_P}/cewl.rb || die
	sed -i "s|require 'mime'|require 'mime/types'|g" ${MY_P}/cewl_lib.rb || die
	sed -i "/gem 'mime'/d" ${MY_P}/Gemfile || die
	sed -i "/gem 'zip'/d" ${MY_P}/Gemfile || die
	rm -f ${MY_P}/Gemfile.lock
}

each_ruby_install() {
	doruby ${MY_P}/cewl_lib.rb ${MY_P}/fab.rb
}

all_ruby_install() {
	dodoc ${MY_P}/README.md
	newbin ${MY_P}/cewl.rb cewl
}

each_ruby_prepare() {
	GEM_HOME="${T}" BUNDLE_GEMFILE=${MY_P}/Gemfile ${RUBY} -S bundle install --local || die
	GEM_HOME="${T}" BUNDLE_GEMFILE=${MY_P}/Gemfile ${RUBY} -S bundle check || die
}
