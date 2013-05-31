# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${PN}_standard-${PV}-fx+sm+tb"
DESCRIPTION="A set of proxy management tools for firefox"
HOMEPAGE="http://getfoxyproxy.org"
SRC_URI="mirror://mozilla/addons/2464/${FFP_XPI_FILE}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
