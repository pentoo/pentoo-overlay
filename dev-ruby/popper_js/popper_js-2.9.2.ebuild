# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
USE_RUBY="ruby26 ruby27 ruby30"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_EXTRAINSTALL="assets"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Popper.js assets as a Ruby gem"
HOMEPAGE="https://github.com/glebm/popper_js-rubygem"
LICENSE="MIT"

KEYWORDS="amd64 ~arm64 x86"
SLOT="2"
IUSE=""
