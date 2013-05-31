# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${PN//-/_}-${PV}-fx+sm"
DESCRIPTION="The first and only download manager/accelerator built inside Firefox!"
HOMEPAGE="http://www.downthemall.net"
SRC_URI=" mirror://mozilla/addons/201/${FFP_XPI_FILE}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
