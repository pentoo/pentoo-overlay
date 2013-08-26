# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/simplecov-html/simplecov-html-0.5.3.ebuild,v 1.1 2013/08/23 22:17:41 zerochaos Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRAINSTALL="assets views"

inherit ruby-fakegem

DESCRIPTION="Generates a nice HTML report of your SimpleCov ruby code coverage results on Ruby 1.9."
HOMEPAGE="https://github.com/colszowka/simplecov"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE="doc"
