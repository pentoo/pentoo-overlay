# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-fx"
DESCRIPTION="Status bar widgets and progress indicators for Firefox 4+"
HOMEPAGE="http://addons.mozilla.org/en-US/firefox/addon/status-4-evar/"
SRC_URI="mirror://mozilla/addons/235283/${FFP_XPI_FILE}.xpi"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
