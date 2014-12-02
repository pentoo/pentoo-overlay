# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}"
FFP_XPI_FILEID="164511"
DESCRIPTION="Firefox extension to display the Exif and IPTC data in local and remote JPEG images."
HOMEPAGE="http://araskin.webs.com/exif/exif.html"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${FFP_XPI_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
