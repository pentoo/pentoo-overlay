# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-fx"
DESCRIPTION="Lets you switch local proxies in firefox. A fork of multiproxy switch."
HOMEPAGE="http://addons.mozilla.org/en-US/firefox/addon/proxy-selector"
SRC_URI="mirror://mozilla/addons/215989/${FFP_XPI_FILE}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
