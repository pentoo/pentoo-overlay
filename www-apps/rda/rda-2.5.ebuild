# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

inherit ruby-single

DESCRIPTION="Web-based application for effective reporting writing"
HOMEPAGE="https://www.itdefence.asia"

LICENSE="none"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+mysql"

#ruby_add_rdepend "dev-ruby/rake

RDEPEND="mysql? ( virtual/mysql )
	dev-ruby/rake
	dev-ruby/rails:5.2
	dev-ruby/activerecord:5.2[mysql?]
	dev-ruby/rack:2.0
	dev-ruby/jquery-rails:4
	dev-ruby/jquery-ui-rails:6
	dev-ruby/will_paginate
	dev-ruby/ckeditor_rails
	dev-ruby/activerecord-session_store
	dev-ruby/similar_text
	dev-ruby/sablon"

each_ruby_prepare() {
	if [ -f Gemfile ]; then
		MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}
