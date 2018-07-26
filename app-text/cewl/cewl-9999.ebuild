# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"
inherit ruby-ng

DESCRIPTION="A custom word list generator"
HOMEPAGE="http://www.digininja.org/projects/cewl.php"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/digininja/CeWL.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/all/CeWL-${PV}"
else
	SRC_URI="https://github.com/digininja/CeWL/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""
MY_P="CeWL-${PV}"

ruby_add_bdepend "dev-ruby/bundler"

ruby_add_rdepend "dev-ruby/nokogiri
		dev-ruby/spider
		dev-ruby/mini_exiftool
		dev-ruby/rubyzip
		dev-ruby/mime-types:*"

#src_unpack() {
#	if [ "${PV}" = "9999" ]; then
#		git-r3_src_unpack
#	fi
#	ruby-ng_src_unpack
#}

all_ruby_prepare() {
	sed -i "s|require './cewl_lib'|require 'cewl_lib'|g" ${MY_P}/cewl.rb
	sed -i "s|require 'mime'|require 'mime/types'|g" ${MY_P}/cewl_lib.rb
}

each_ruby_install() {
	doruby ${MY_P}/cewl_lib.rb ${MY_P}/fab.rb
}

all_ruby_install() {
	dodoc ${MY_P}/README
	newbin ${MY_P}/cewl.rb cewl
}

each_ruby_prepare() {
	if [ -f Gemfile ]; then
		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}
