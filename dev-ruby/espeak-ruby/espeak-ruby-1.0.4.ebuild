# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

inherit ruby-fakegem

DESCRIPTION="espeak-ruby is small Ruby API for utilizing ‘espeak’ and ‘lame’ to create Text-To-Speech mp3 files"
HOMEPAGE="https://github.com/dejan/espeak-ruby"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test

#ruby_add_rdepend "dev-ruby/nio4r:2
#	>=dev-ruby/timers-4.1 =dev-ruby/timers-4*
#"
