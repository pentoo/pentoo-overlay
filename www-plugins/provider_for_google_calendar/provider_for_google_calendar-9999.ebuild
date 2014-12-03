# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="thunderbird"
inherit mozilla-addon

MOZ_ADDON_ID=4631
DESCRIPTION="Allows Lightning to read and write events and tasks to a Google Calendar"
HOMEPAGE="http://addons.mozilla.org/en-us/thunderbird/addon/provider-for-google-calendar/"
SRC_URI="http://addons.mozilla.org/thunderbird/downloads/file/${MOZ_ADDON_ID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	www-plugins/lightning"
DEPEND+="
	www-plugins/lightning"

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
