# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gems

USE_RUBY="ruby18"

DESCRIPTION="wrapper for exiftool"
HOMEPAGE="http://rubyforge.org/projects/miniexiftool/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="$RDEPEND
		media-libs/exiftool"
