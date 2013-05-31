# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${PN//-/_}-${PV}-fx+sm"
DESCRIPTION="Adds a menu and a toolbar button to switch the user agent of firefox"
HOMEPAGE="http://chrispederick.com/work/user-agent-switcher"
SRC_URI="mirror://mozilla/addons/59/${FFP_XPI_FILE}.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
