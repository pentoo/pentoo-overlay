# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-tb+an+sm+fx"
DESCRIPTION="Firefox extension to block annoying ads automatically, no distractions."
HOMEPAGE="http://adblockplus.org/en/firefox"
SRC_URI="mirror://mozilla/addons/1865/${FFP_XPI_FILE}.xpi"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
