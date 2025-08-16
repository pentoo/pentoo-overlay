# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

inherit ruby-fakegem

DESCRIPTION="Performs the UNIX crypt(3) algorithm"
HOMEPAGE="https://rubygems.org/gems/unix-crypt"

KEYWORDS="amd64 arm64 x86"
LICENSE="BSD"
SLOT="0"

#ruby_add_rdepend ""
