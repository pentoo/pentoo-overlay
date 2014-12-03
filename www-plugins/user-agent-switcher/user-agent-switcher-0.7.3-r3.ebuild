# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="firefox"
inherit mozilla-addon

MOZ_FILEID="107207"
DESCRIPTION="Adds a menu and a toolbar button to switch the user agent of firefox"
HOMEPAGE="http://chrispederick.com/work/user-agent-switcher"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${MOZ_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
