# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-fakegem versionator

#RUBY_FAKEGEM_EXTRAINSTALL="app config db spec"

DESCRIPTION="Adds missing native PostgreSQL data types to ActiveRecord and convenient querying extensions for ActiveRecord and Arel"
HOMEPAGE="https://github.com/dockyard/postgres_ext"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-3)"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT=test

all_ruby_prepare() {
        [ -f Gemfile.lock ] && rm Gemfile.lock
        #if ! use development; then
                sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
                sed -i -e "/s.add_development_dependency/d" "${PN}".gemspec || die
		sed -i -e "/gem.add_development_dependency/d" "${PN}".gemspec || die
        #fi
        #if ! use test; then
                sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
        #fi
        #if ! use test && ! use development; then
                sed -i -e "/^group :development, :test do/,/^end$/d" Gemfile || die
        #fi
}

each_ruby_prepare() {
        if [ -f Gemfile ]
        then
                BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
                BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
        fi
}
