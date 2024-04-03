# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"

inherit ruby-single

DESCRIPTION="Web-based application for effective reporting writing"
HOMEPAGE="https://www.itdefence.asia"

LICENSE="default_evil"
SLOT="3"
KEYWORDS="~amd64"
IUSE="mysql mariadb"

RDEPEND="dev-ruby/mysql2[mysql?,mariadb?]
	dev-ruby/rails:6.1
	|| ( dev-ruby/activerecord:7.1 dev-ruby/activerecord:7.0 dev-ruby/activerecord:6.1 )
	dev-ruby/activerecord-session_store
	dev-ruby/bootstrap
	dev-ruby/ckeditor_rails
	dev-ruby/jbuilder
	dev-ruby/jquery-rails:4
	dev-ruby/jquery-ui-rails:6
	dev-ruby/mini_magick
	media-gfx/imagemagick[png,jpeg]
	dev-ruby/rake
	dev-ruby/sablon
	dev-ruby/similar_text
	dev-ruby/will_paginate
	dev-ruby/grape
	dev-ruby/rack-cors
	dev-ruby/grape-active_model_serializers
	dev-ruby/sass-rails:*
	dev-ruby/coffee-rails
	"
