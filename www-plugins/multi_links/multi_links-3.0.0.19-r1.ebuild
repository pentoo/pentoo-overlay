# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-fx"
DESCRIPTION="Firefox extension  open, copy or bookmark multiple links at the same time"
HOMEPAGE="http://www.grizzlyape.com/addons/multi-links/"
SRC_URI="mirror://mozilla/addons/13494/${FFP_XPI_FILE}.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
