# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33 ruby34"

inherit ruby-fakegem

DESCRIPTION="A small API for utilizing 'espeak' and 'lame' to create Text-To-Speech mp3 files"
HOMEPAGE="https://github.com/dejan/espeak-ruby"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test
