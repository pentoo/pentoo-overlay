# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

inherit ruby-fakegem

DESCRIPTION="A small API for utilizing 'espeak' and 'lame' to create Text-To-Speech mp3 files"
HOMEPAGE="https://github.com/dejan/espeak-ruby"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test

#ruby_add_rdepend "dev-ruby/nio4r:2
#	>=dev-ruby/timers-4.1 =dev-ruby/timers-4*
#"
