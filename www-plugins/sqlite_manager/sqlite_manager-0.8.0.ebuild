# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-fx+sm+tb"
PLUGIN_ID=5817
DESCRIPTION="Extension for Firefox and other apps to manage any sqlite database"
HOMEPAGE="http://code.google.com/p/sqlite-manager"
SRC_URI="mirror://mozilla/addons/${PLUGIN_ID}/${FFP_XPI_FILE}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
