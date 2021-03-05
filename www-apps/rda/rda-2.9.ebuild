# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"

inherit ruby-single

DESCRIPTION="Web-based application for effective reporting writing"
HOMEPAGE="https://www.itdefence.asia"

LICENSE="none"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+mysql"

RDEPEND="mysql? ( virtual/mysql )
	dev-ruby/activerecord:5.2[mysql?]
	dev-ruby/activerecord-session_store
	dev-ruby/bootstrap
	dev-ruby/ckeditor_rails
	dev-ruby/jquery-rails:4
	dev-ruby/jquery-ui-rails:6
	dev-ruby/mini_magick
	media-gfx/imagemagick[png,jpeg]
	dev-ruby/rails:5.2
	dev-ruby/rake
	dev-ruby/sablon
	dev-ruby/similar_text
	dev-ruby/will_paginate
	dev-ruby/grape
	dev-ruby/rack-cors
	dev-ruby/grape-active_model_serializers
	"
