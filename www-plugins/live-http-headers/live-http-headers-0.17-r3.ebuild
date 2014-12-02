# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}"
FFP_XPI_FILEID="119979"
DESCRIPTION="View HTTP headers of a page and while browsing"
HOMEPAGE="http://livehttpheaders.mozdev.org/"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${FFP_XPI_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
