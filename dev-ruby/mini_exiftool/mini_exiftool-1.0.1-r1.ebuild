# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

USE_RUBY="ruby18 ruby19"

inherit ruby-fakegem

DESCRIPTION="wrapper for exiftool"
HOMEPAGE="http://rubyforge.org/projects/miniexiftool/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/exiftool"
