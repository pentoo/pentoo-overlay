# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-sm+fx"
DESCRIPTION="A HTTP analyzer addon for Firefox"
HOMEPAGE="http://code.google.com/p/httpfox"
SRC_URI="mirror://mozilla/addons/6647/${FFP_XPI_FILE}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
