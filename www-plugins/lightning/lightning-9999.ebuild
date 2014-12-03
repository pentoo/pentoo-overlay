# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="thunderbird"
inherit mozilla-addon

MOZ_ADDON_ID=2313
DESCRIPTION="Lightning calendar for Thunderbird"
HOMEPAGE="http://www.mozilla.org/en-US/projects/calendar/"
SRC_URI="http://addons.mozilla.org/thunderbird/downloads/file/${MOZ_ADDON_ID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
