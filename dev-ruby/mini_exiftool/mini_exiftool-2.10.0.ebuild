# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

inherit ruby-fakegem

DESCRIPTION="wrapper for exiftool"
HOMEPAGE="https://rubygems.org/gems/mini_exiftool"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/exiftool"
