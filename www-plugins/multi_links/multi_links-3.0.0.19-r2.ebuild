# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="firefox"
inherit mozilla-addon

MOZ_FILEID="139561"
DESCRIPTION="Firefox extension  open, copy or bookmark multiple links at the same time"
HOMEPAGE="http://www.grizzlyape.com/addons/multi-links/"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${MOZ_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
