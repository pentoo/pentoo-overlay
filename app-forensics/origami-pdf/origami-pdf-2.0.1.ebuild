# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"

RUBY_FAKEGEM_NAME="origami"
#RUBY_FAKEGEM_TASK_TEST="test"

inherit ruby-fakegem

DESCRIPTION="A Ruby framework designed to parse, analyze, and forge PDF documents"
HOMEPAGE="https://github.com/gdelugre/origami"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

ruby_add_bdepend "test? ( dev-ruby/minitest:5 )
		dev-ruby/bundler"

ruby_add_rdepend " dev-ruby/colorize
	gtk? ( dev-ruby/ruby-gtk2 )"

#each_ruby_prepare() {
#	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
#	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
#}

all_ruby_install(){
	all_fakegem_install

	#Gentoo bug, remove links to directories
	rm "${ED}usr/bin"/shell
	rm "${ED}usr/bin"/gui
	rm "${ED}usr/bin"/config

}
