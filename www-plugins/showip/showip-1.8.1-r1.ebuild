# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-tb+sm+fx"
DESCRIPTION="Firefox extensions which shows the IP address(es) of the current page in the status bar."
HOMEPAGE="http://code.google.com/p/firefox-showip"
SRC_URI="mirror://mozilla/addons/590/${FFP_XPI_FILE}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
