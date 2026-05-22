# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"

inherit ruby-fakegem

DESCRIPTION="A replacement for the URI implementation that is part of Ruby's standard library"
HOMEPAGE="https://rubygems.org/gems/addressable https://github.com/sporkmonger/addressable"

LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

ruby_add_rdepend "|| ( dev-ruby/public_suffix:7 dev-ruby/public_suffix:6 )"
