# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31 ruby32"

RUBY_FAKEGEM_EXTENSIONS=(ext/similar_text/extconf.rb)
inherit ruby-fakegem

DESCRIPTION="Calculate the similarity between two strings"
HOMEPAGE="https://github.com/valcker/similar_text-ruby"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""
