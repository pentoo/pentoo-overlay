# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby30 ruby31 ruby32"
RUBY_FAKEGEM_EXTENSIONS=(ext/io/console/extconf.rb)

inherit ruby-fakegem

DESCRIPTION="add console capabilities to IO instances."
HOMEPAGE="https://github.com/ruby/io-console"

KEYWORDS="amd64 arm64 x86"
LICENSE="BSD"
SLOT="0"

# No Rakefile in the gem?
RESTRICT=test
