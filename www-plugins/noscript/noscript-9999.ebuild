# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}"
PLUGIN_ID=722
DESCRIPTION="Allow active content in firefox to run only from trusted sites."
HOMEPAGE="http://noscript.net"
SRC_URI="http://addons.mozilla.org/firefox/downloads/latest/${PLUGIN_ID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
