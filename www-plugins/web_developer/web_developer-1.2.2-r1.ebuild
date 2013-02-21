# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-fx+sm"
DESCRIPTION="Adds various web developer tools to firefox."
HOMEPAGE="http://chrispederick.com/work/web-developer"
SRC_URI="mirror://mozilla/addons/60//${FFP_XPI_FILE}.xpi"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
