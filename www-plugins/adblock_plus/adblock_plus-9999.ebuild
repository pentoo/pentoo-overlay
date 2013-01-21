# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}"
PLUGIN_ID=1865
DESCRIPTION="Firefox extension to block annoying ads automatically, no distractions."
HOMEPAGE="http://adblockplus.org/en/firefox"
SRC_URI="http://addons.mozilla.org/firefox/downloads/latest/${PLUGIN_ID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
